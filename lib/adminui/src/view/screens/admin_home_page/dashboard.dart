import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ssp_admin_panel/src/view/screens/admin_home_page/home_page.dart';
import 'package:ssp_admin_panel/src/view/screens/admin_home_page/home_page_controller.dart';
import 'package:ssp_admin_panel/src/view/screens/all_product_screen/all_products.dart';


import '../orders_screen/order_screen.dart';
import '../profile_screen/profile_screen.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);

  final AdminPageController controller = Get.find<AdminPageController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminPageController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex.value,
            children: [
              HomePage(),
              AllProductScreen(),
              OrderScreen(),
              const ProfileScreen(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          currentIndex: controller.tabIndex.value,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Products",
              icon: Icon(Icons.shopping_bag),
            ),
            BottomNavigationBarItem(
              label: "Orders",
              icon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person),
            ),
          ],
          onTap: (index) {
            controller.changeTabIndex(index);
          },
        ),
      );
    });
  }
}
