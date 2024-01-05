import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/product.dart';

class AllProductsController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  clearproducts() {
    products.clear();
    update();
  }

  Future<RxList<Product>> getProducts() async {
    try {
      await db.collection('product').get().then((snapshot) {
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
    update();
    return products;
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await db.collection('product').doc(product.docId).delete();
      products.remove(product);
      Get.toNamed('/home/');
      update();
    } catch (e) {
      Get.snackbar(
        'Error:',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
