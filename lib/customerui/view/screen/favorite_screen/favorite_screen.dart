import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smartstock_pro/customerui/controller/product_controller.dart';
import 'package:smartstock_pro/widgets/product_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(13, 41, 71,1),
            title: const Text("Favorites",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ProductGridView(
              items: controller.favoriteProducts,
            ),
          ),
        );
      },
    );
  }
}
