import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreenController extends GetxController {
  final orders = [].obs;
  final productDetails = RxList<Map<String, dynamic>>();
  final userData = Rx<Map<String, dynamic>>({});
  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      List<DocumentSnapshot> docs = querySnapshot.docs;
      for (var doc in docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['orderId'] = doc.id;
        Map<String, dynamic> userData = await fetchUserData(data['userId']);
        data['name'] = userData['name'];
        data['address'] = userData['address'];
        orders.add(data);

        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void fetchProductDetails(Map<String, dynamic> order) async {
    List<dynamic> cartProducts = order['cartProducts'];

    List<Map<String, dynamic>> fetchedProducts = [];

    for (var product in cartProducts) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('product')
            .where('name', isEqualTo: product['name'])
            .get();

        var products = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['productId'] = doc.id;

          orders.add(data);
          return data;
        }).toList();

        fetchedProducts.addAll(products);
      } catch (e) {
        Get.snackbar(
          'Error:',
          e.toString(),
          backgroundColor: Colors.red,
        );
      }
    }

    productDetails.assignAll(fetchedProducts);
  }

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      Map<String, dynamic> fullData = userDoc.data() as Map<String, dynamic>;

      return {
        'name': fullData['name'],
        'address': fullData['address'],
      };
    } catch (e) {
      Get.snackbar(
        'Error:',
        e.toString(),
        backgroundColor: Colors.red,
      );
      return {};
    }
  }
}
