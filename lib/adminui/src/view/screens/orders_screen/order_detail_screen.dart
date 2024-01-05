import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssp_admin_panel/src/view/screens/admin_home_page/dashboard.dart';
import 'package:ssp_admin_panel/src/view/screens/orders_screen/order_screen_controller.dart';
import 'package:intl/intl.dart';
import 'package:ssp_admin_panel/widgets/text.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderScreenController orderController =
      Get.find<OrderScreenController>();

  OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> order = Get.arguments;
    orderController.fetchProductDetails(order);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(() => DashBoardScreen());
          },
        ),
        title:
            const Text('Order Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: ${order['orderId']}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple)),
                    const SizedBox(height: 10),
                    NormalText(text: 'User name: ${order['name']}'),
                    const SizedBox(height: 10),
                    NormalText(
                      text: 'Address: ${order['address']}',
                    ),
                    const SizedBox(height: 10),
                    NormalText(
                      text:
                          'Order Date: ${DateFormat('dd MMMM yyyy').format(order['timestamp'].toDate())}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: SubHeading(
                  text: 'Products',
                  color: Colors.deepPurple,
                ),
              ),
              Obx(() {
                if (orderController.productDetails.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: min(orderController.productDetails.length,
                        order['cartProducts'].length),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> product =
                          orderController.productDetails[index];
                      Map<String, dynamic> cartProduct =
                          order['cartProducts'][index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.network(
                                product['image'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SubHeading(text: product['name']),
                                  NormalText(
                                    text:
                                        'Price: ${product['price']} \nQuantity: ${cartProduct['quantity']}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
              const SizedBox(height: 20),
              SubHeading(text: 'Total Amount: ${order['totalPrice']}'),
            ],
          ),
        ),
      ),
    );
  }
}
