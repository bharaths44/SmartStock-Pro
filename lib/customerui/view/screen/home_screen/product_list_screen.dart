
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartstock_pro/customerui/controller/product_controller.dart';

import 'package:smartstock_pro/widgets/list_item_selector.dart';
import 'package:smartstock_pro/widgets/product_grid_view.dart';

class ProductListScreen extends StatelessWidget {
  final controller = Get.find<ProductController>();

  ProductListScreen({super.key});
  Widget _topCategoriesHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Categories",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget _topCategoriesListView() {
    return ListItemSelector(
      categories: controller.categories,
      onItemPressed: (index) {
        controller.filterItemsByCategory(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // controller.getAllItems();
    return GetBuilder<ProductController>(
      builder: (controller) {
        controller.fetchUsername();
        if (controller.username.value == '') {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(13, 41, 71, 1),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello ${controller.username}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "Lets gets somethings?",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      _topCategoriesHeader(context),
                      _topCategoriesListView(),
                      GetBuilder<ProductController>(
                          init: controller,
                          builder: (controller) {
                            return ProductGridView(
                              items: controller.filteredProducts,
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
