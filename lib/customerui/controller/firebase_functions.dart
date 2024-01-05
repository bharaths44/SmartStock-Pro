import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartstock_pro/adminui/src/model/product.dart';
import 'package:smartstock_pro/customerui/model/product_category.dart';

class FirebaseFunctions {
  String dbRef1 = 'product';
  String dbRef2 = 'product_category';
  String dbRef3 = 'users';
  List<ProductCategory> categories = [];

  List<Product> products = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<List<Product>> getProducts() async {
    try {
      await db.collection(dbRef1).get().then((snapshot) {
        for (var doc in snapshot.docs) {
          products.add(Product.fromFirestore(doc));
        }
      });
    } catch (e) {
      Get.snackbar(
        'Error:',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
    return products;
  }

  Future<void> addProduct() async {
    String productName = "iphone 13";
    await db.collection(dbRef1).doc(productName).set({
      'name': "iphone 13",
      'about':
          "Experience the pinnacle of innovation with the iPhone 13. Its advanced A15 Bionic chip, stunning Super Retina XDR display, and professional-grade camera system redefine smartphone technology. From capturing life's moments to seamless performance, the iPhone 13 delivers excellence in every touch",
      'price': 90000,
      'isAvailable': true,
      'image': "https://www.dslr-zone.com/wp-content/uploads/2021/10/5-2.jpeg",
      'type': "mobile",
      'stock': 10,
    });
  }

  Future<void> addFavoriteItem(String userId, String productName) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference userDoc = db.collection('users').doc(userId);
    await userDoc.update({
      'favorites': FieldValue.arrayUnion([productName]),
    });
  }

  Future<void> removeFavoriteItem(String userId, String productName) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference userDoc = db.collection('users').doc(userId);
    await userDoc.update({
      'favorites': FieldValue.arrayRemove([productName]),
    });
  }

  Future<List<String>> getFavoriteItems(String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference userDoc = db.collection('users').doc(userId);
    DocumentSnapshot userDocSnapshot = await userDoc.get();

    if (userDocSnapshot.exists) {
      List<String> favorites = List<String>.from(userDocSnapshot['favorites']);
      return favorites;
    } else {
      throw Exception('User not found');
    }
  }

  String? getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<void> storeCartItems(String userId, List<Product> cartProducts) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    // Prepare the cart data
    Map<String, dynamic> cartData = {};
    for (Product product in cartProducts) {
      cartData[product.name] = {
        'quantity': product.quantity,
        'price': product.price,
      };
    }

    // Store the cart data in the 'users' collection
    DocumentReference userDoc = db.collection('users').doc(userId);
    await userDoc.update({'cart': cartData});
  }

  Future<void> newOrder(
      List<Product> cartProducts, int totalPrice, String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    // Prepare the order data
    Map<String, dynamic> orderData = {
      'timestamp': Timestamp.now(),
      'cartProducts': cartProducts
          .map((product) => {
                'name': product.name,
                'quantity': product.quantity,
                'price': product.price,
              })
          .toList(),
      'totalPrice': totalPrice,
      'userId': userId,
    };
    await db.collection('orders').add(orderData);
  }
  Future<List<Object?>> getUserOrders(String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    // Get the orders of the current user
    QuerySnapshot querySnapshot = await db.collection('orders')
        .where('userId', isEqualTo: userId)
        .get();

    // Convert the documents to a list of maps
    List<Object?> orders = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    return orders;
  }
}
