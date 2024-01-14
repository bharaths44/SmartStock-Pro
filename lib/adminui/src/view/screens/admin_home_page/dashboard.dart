import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartstock_pro/adminui/src/view/screens/admin_home_page/home_page.dart';
import 'package:smartstock_pro/adminui/src/view/screens/admin_home_page/home_page_controller.dart';
import 'package:smartstock_pro/adminui/src/view/screens/all_product_screen/all_products.dart';
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
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.tabIndex.value,
          onDestinationSelected: (index) {
            controller.changeTabIndex(index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag),
              label: "Products",
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: "Orders",
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}
