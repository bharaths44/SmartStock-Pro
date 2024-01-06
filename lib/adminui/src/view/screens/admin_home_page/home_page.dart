import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartstock_pro/widgets/customappbar.dart';

import 'home_page_controller.dart';

class HomePage extends StatelessWidget {
  final AdminPageController controller = Get.put(AdminPageController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Admin DashBoard',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            bigTitleCard(
                'Total Money Earned', controller.totalMoneyEarned, Icons.money),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  statsCard('Total Orders', controller.totalOrders,
                      Icons.shopping_cart_outlined),
                  statsCard('Total Users', controller.totalUsers,
                      Icons.people_outline_outlined),
                  statsCard(
                      'Most Ordered Product',
                      controller.mostOrderedProduct,
                      Icons.shopping_basket_outlined),
                  statsCard('Average Order Value', controller.averageOrderValue,
                      Icons.receipt_long),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statsCard(String title, dynamic value, IconData icon) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        margin:
            const EdgeInsets.all(16), // Add margins for visual breathing room
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Subtle rounded corners
          side: BorderSide(
            color: Colors.grey.shade300, // Softer border for definition
            width: 1,
          ),
        ),

        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,
                  size: Get.size.width * 0.1,
                  color: Colors.deepPurple), // Vibrant icon color
              Obx(() => Text(
                    '$title: ${value.value}',
                    style: TextStyle(
                      fontSize: Get.size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black text for clarity
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bigTitleCard(String title, dynamic value, IconData icon) {
  return Card(
    margin: EdgeInsets.all(
        Get.size.width * 0.02), // Add margins for visual breathing room
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Subtle rounded corners
      side: BorderSide(
        color: Colors.grey.shade300, // Softer border for definition
        width: 1,
      ),
    ),
    elevation: 0,
    color: Colors.white,
    child: SizedBox(
      height: Get.size.height / 4,
      child: Padding(
        padding: EdgeInsets.all(Get.size.width * 0.02),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,
                  size: Get.size.width * 0.125, color: Colors.deepPurple),
              Obx(() => Text(
                    '$title: \n${value.value}',
                    style: TextStyle(
                        fontSize: Get.size.width * 0.06,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    ),
  );
}
