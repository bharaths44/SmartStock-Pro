import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smartstock_pro/adminui/src/model/product.dart';
import 'package:smartstock_pro/customerui/controller/product_controller.dart';

final ProductController controller = Get.put(ProductController());

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

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
          image: NetworkImage(
        product.image,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return SafeArea(
      child: Scaffold(
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
                                style:
                                    Theme.of(context).textTheme.displayMedium,
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
                                    product.isAvailable
                                        ? "Available in stock"
                                        : "Not available",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "About",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
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
              SizedBox(
                width: Get.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(13, 41, 71, 1),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: product.isAvailable
                      ? () => controller.addToCart(product)
                      : null,
                  child: const Text("Add to cart"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
