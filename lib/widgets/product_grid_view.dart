import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:e_commerce_flutter/src/customerview/view/animation/open_container_wrapper.dart';
import 'package:get/get.dart';

import '../customerview/controller/product_controller.dart';

class ProductGridView extends StatelessWidget {
  ProductGridView({
    Key? key,
    required this.items,
  }) : super(key: key);
  final ProductController controller = Get.find<ProductController>();
  final List<Product> items;
  Widget _gridItemHeader(Product product, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() {
            return IconButton(
              icon: Icon(
                Icons.favorite,
                color: (controller.likedProducts[product.name] ?? false)
                    ? Colors.red
                    : Colors.grey,
              ),
              onPressed: () {
                controller.isFavorite(index);
                controller.likedProducts[product.name] =
                    !(controller.likedProducts[product.name] ?? false);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _gridItemBody(Product product) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E6E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image(
          image: NetworkImage(
            product.image,
          ),
        ));
  }

  Widget _gridItemFooter(Product product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        //height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                Text("₹${product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 10 / 16,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          Product product = items[index];
          return OpenContainerWrapper(
            product: product,
            child: GridTile(
              header: _gridItemHeader(product, index),
              footer: _gridItemFooter(product, context),
              child: _gridItemBody(product),
            ),
          );
        },
      ),
    );
  }
}
