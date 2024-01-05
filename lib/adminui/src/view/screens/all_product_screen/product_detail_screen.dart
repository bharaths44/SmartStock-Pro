import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ssp_admin_panel/src/view/screens/all_product_screen/all_product_controller.dart';
import 'package:ssp_admin_panel/widgets/alertbox.dart';

import '../../../model/product.dart';
import '../update_product/update_product.dart';

final AllProductsController controller = Get.find<AllProductsController>();

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({Key? key}) : super(key: key);

  final Product product = Get.arguments;

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  Widget productPageView(double width, double height) {
    return Container(
      height: height * 0.3,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E6E8),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(200),
          bottomLeft: Radius.circular(200),
        ),
      ),
      child: Image(
          fit: BoxFit.contain,
          image: NetworkImage(
            product.image,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    productPageView(width, height),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(height: 10),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text("₹${product.price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30,
                                    )),
                                const SizedBox(width: 3),
                                const Spacer(),
                                Text(
                                  "Stock: ${product.stock}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
                            Text(
                              "Description ",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(product.about),
                            const SizedBox(height: 20),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: Get.width * 0.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(13, 41, 71, 1),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: product.isAvailable
                        ? () {
                            Get.to(() => UpdateProductScreen(),
                                arguments: product);
                          }
                        : null,
                    child: const Text("Update product"),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(13, 41, 71, 1),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      AlertBox(
                        message:
                            "Are you sure you want to delete this product?",
                        onConfirm: () => controller.deleteProduct(product),
                      ).show();
                    },
                    child: const Text("Delete product"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
