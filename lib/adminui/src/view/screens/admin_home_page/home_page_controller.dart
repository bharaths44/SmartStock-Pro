import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPageController extends GetxController {
  RxInt tabIndex = 0.obs;
  RxNum totalOrders = RxNum(0);
  RxNum totalUsers = RxNum(0);
  RxNum totalMoneyEarned = RxNum(0.0);

  RxString averageOrderValue = ''.obs;
  RxString mostOrderedProduct = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateTotalOrders();
    updateTotalUsers();
    updateTotalMoneyEarned();
    calculateMostOrderedProduct();
    calculateAverageOrderValue();
  }

  changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  initTabIndex() {
    tabIndex.value = 0;
  }

  void updateTotalOrders() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('orders').snapshots().listen((snapshot) {
      totalOrders.value = snapshot.docs.length;
      calculateAverageOrderValue();
      update();
    });
  }

  void updateTotalUsers() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('users')
        .where('isAdmin', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      totalUsers.value = snapshot.docs.length;
      update();
    });
  }

  void updateTotalMoneyEarned() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('orders').snapshots().listen((snapshot) {
      double totalMoney = 0.0;
      for (var doc in snapshot.docs) {
        totalMoney += (doc.data())['totalPrice'] ?? 0;
      }
      totalMoneyEarned.value = totalMoney;
      calculateAverageOrderValue();
      update();
    });
  }

  void calculateMostOrderedProduct() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, int> productQuantities = {};

    firestore.collection('orders').snapshots().listen((snapshot) {
      for (var doc in snapshot.docs) {
        var cartProducts = (doc.data())['cartProducts'] ?? [];
        for (var product in cartProducts) {
          String productName = product['name'];
          int quantity = product['quantity'];
          if (productQuantities.containsKey(productName)) {
            productQuantities[productName] =
                (productQuantities[productName] ?? 0) + quantity;
          } else {
            productQuantities[productName] = quantity;
          }
        }
      }

      String maxOrderedProduct = '';
      int maxQuantity = 0;
      productQuantities.forEach((product, quantity) {
        if (quantity > maxQuantity) {
          maxQuantity = quantity;
          maxOrderedProduct = product;
        }
      });

      if (maxOrderedProduct.isNotEmpty) {
        mostOrderedProduct.value = maxOrderedProduct;
        update();
      }
    });
  }

  void calculateAverageOrderValue() {
    if (totalOrders.value > 0) {
      averageOrderValue.value =
          (totalMoneyEarned.value / totalOrders.value).toStringAsFixed(2);
    } else {
      averageOrderValue.value = '0.0';
    }
    update();
  }
}
