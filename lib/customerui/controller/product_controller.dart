import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartstock_pro/adminui/src/model/product.dart';
import 'package:smartstock_pro/adminui/src/view/screens/profile_screen/profile_screen.dart';
import 'package:smartstock_pro/customerui/controller/firebase_functions.dart';
import 'package:smartstock_pro/customerui/core/app_data.dart';
import 'package:smartstock_pro/customerui/model/product_category.dart';
import 'package:smartstock_pro/customerui/view/screen/home_screen/home_controller.dart';


class ProductController extends GetxController {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  var userid = FirebaseFunctions().getCurrentUserId();
  RxBool isSelected = false.obs;
  List<Product> allProducts = [];
  RxList<Product> filteredProducts = <Product>[].obs;
  RxList<Product> cartProducts = <Product>[].obs;
  RxList<Product> favoriteProducts = <Product>[].obs;
  RxList<ProductCategory> categories = AppData.categories.obs;
  RxInt totalPrice = 0.obs;
  RxString username = ''.obs;
  RxBool isLiked = false.obs;
  RxMap<String, bool> likedProducts = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    //filterItemsByCategory(0);
  }

  Future<void> fetchUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    username.value = await getUserName(user);
    userid = FirebaseFunctions().getCurrentUserId();
  }

  getAllItems() {
    filteredProducts.assignAll(allProducts.toList());
  }

  Future<void> fetchProducts() async {
    allProducts = await firebaseFunctions.getProducts();
    filteredProducts.assignAll(allProducts.toList());

    getFavoriteItems().then((_) => populateLikedProducts());
  }

  Future<void> filterItemsByCategory(int index) async {
    if (allProducts.isEmpty) {
      await fetchProducts();
    }
    for (ProductCategory element in categories) {
      element.isSelected = false;
    }
    categories[index].isSelected = true;

    if (index == 0) {
      filteredProducts.assignAll(allProducts.toList());
    } else {
      filteredProducts.assignAll(allProducts.where((item) {
        return item.type == categories[index].type;
      }).toList());
    }

    update();
  }

//Favorite Function
  Future<void> isFavorite(int index) async {
    var product = filteredProducts[index];

    var docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();

    var favorites = docSnapshot.data()?['favorites'] ?? [];
    var isFavorite = favorites.contains(product.name);

    await FirebaseFirestore.instance.collection('users').doc(userid).update({
      'favorites': isFavorite
          ? FieldValue.arrayRemove([product.name])
          : FieldValue.arrayUnion([product.name]),
    });
    likedProducts[product.name] = !isFavorite;
    getFavoriteItems();
    update();
  }

  Future<void> getFavoriteItems() async {
    var docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    var favorites = docSnapshot.data()?['favorites'] ?? [];

    favoriteProducts.assignAll(
      allProducts.where((product) {
        return favorites.contains(product.name);
      }).toList(),
    );
    update();
  }

  Future<void> populateLikedProducts() async {
    var docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    var favorites = docSnapshot.data()?['favorites'] ?? [];

    for (var product in allProducts) {
      likedProducts[product.name] = favorites.contains(product.name);
    }

    // Update the UI
    update();
  }

//Cart Function
  void addToCart(Product product) {
    var foundProduct =
        cartProducts.firstWhereOrNull((p) => p.name == product.name);

    if (foundProduct != null) {
      foundProduct.quantity++;
    } else {
      product.quantity = 1;
      cartProducts.add(product);
    }

    FirebaseFirestore.instance.collection('users').doc(userid).update({
      'cart': cartProducts
          .map((product) => {
                'name': product.name,
                'quantity': product.quantity,
                'price': product.price,
                'totalPrice': product.price * product.quantity,
              })
          .toList(),
    });

    calculateTotalPrice();
    update();
  }

  void increaseItemQuantity(Product product) {
    product.quantity++;

    FirebaseFirestore.instance.collection('users').doc(userid).update({
      'cart': cartProducts
          .map((product) => {
                'name': product.name,
                'quantity': product.quantity,
                'price': product.price,
                'totalPrice': product.price * product.quantity,
              })
          .toList(),
    });

    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(Product product) {
    product.quantity--;
    if (product.quantity <= 0) {
      cartProducts.remove(product);
    }

    FirebaseFirestore.instance.collection('users').doc(userid).set({
      'cart': cartProducts
          .map((product) => {
                'name': product.name,
                'quantity': product.quantity,
                'price': product.price,
                'totalPrice': product.price * product.quantity,
              })
          .toList(),
    }, SetOptions(merge: true));

    calculateTotalPrice();
    update();
  }

  bool get isEmptyCart => cartProducts.isEmpty;

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      totalPrice.value += (element.quantity * element.price);
    }
  }

  void storeOrderDetails() async {
    await firebaseFunctions.newOrder(cartProducts, totalPrice.value, userid!);

    // Empty the cart
    cartProducts.clear();
    calculateTotalPrice();
    update();

    DashBoardController controller = Get.find<DashBoardController>();
    controller.initTabIndex();
    Get.offAllNamed('/home/');
  }

  getOrderDetails() async {
    await firebaseFunctions.getUserOrders(userid!);
  }
}
