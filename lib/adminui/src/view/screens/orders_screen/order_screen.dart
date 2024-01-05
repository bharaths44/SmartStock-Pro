import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/customappbar.dart';
import 'order_screen_controller.dart';
import 'order_detail_screen.dart';

class OrderScreen extends StatelessWidget {
  final OrderScreenController controller =
      Get.put(OrderScreenController(), permanent: true);

  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
       title: 'Orders',
      ),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return const Center(child: Text('No orders found'));
        } else {
          final validOrders = controller.orders
              .where((order) => order['orderId'] != null)
              .toList();
          return ListView.builder(
            itemCount: validOrders.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  Get.off(() => OrderDetailScreen(),
                      arguments: validOrders[index]);
                },
                child: Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.shopping_cart),
                    ),
                    title: Text(
                      'Order #${validOrders[index]['orderId'].substring(validOrders[index]['orderId'].length - 5)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      'Total Price: ${validOrders[index]['totalPrice']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: const Icon(Icons.navigate_next),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
