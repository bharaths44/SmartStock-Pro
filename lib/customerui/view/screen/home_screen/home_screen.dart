import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:smartstock_pro/customerui/view/screen/cart_screen/cart_screen.dart';
import 'package:smartstock_pro/customerui/view/screen/favorite_screen/favorite_screen.dart';
import 'package:smartstock_pro/customerui/view/screen/home_screen/home_controller.dart';
import 'package:smartstock_pro/customerui/view/screen/home_screen/product_list_screen.dart';
import 'package:smartstock_pro/customerui/view/screen/profile_screen/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final DashBoardController controller = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(13, 41, 71, 1),
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex.value,
            children: [
              ProductListScreen(),
              FavoriteScreen(),
              const CartScreen(),
              const ProfileScreen()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: const Color.fromRGBO(13, 41, 71, 1),
          unselectedItemColor: Colors.grey,
          currentIndex: controller.tabIndex.value,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Favorite",
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              label: "Cart",
              icon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person),
            ),
          ],
          onTap: (index) {
            controller.changeTabIndex(index);
            //Get.find<ProductController>().fetchProducts();
          },
        ),
      );
    });
  }
}
