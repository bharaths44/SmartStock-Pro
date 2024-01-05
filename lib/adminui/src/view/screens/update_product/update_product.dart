import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssp_admin_panel/src/view/screens/admin_home_page/dashboard.dart';
import 'package:ssp_admin_panel/src/view/screens/update_product/update_product_controller.dart';

import '../../../../core/appdata.dart';
import '../../../../widgets/customappbar.dart';

class UpdateProductScreen extends StatelessWidget {
  final UpdateProductController controller =
      Get.put(UpdateProductController(Get.arguments));

  UpdateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Update Products',
        leading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controller.name,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextFormField(
              controller: controller.about,
              decoration: const InputDecoration(labelText: 'Product About'),
            ),
            TextFormField(
              controller: controller.price,
              decoration: const InputDecoration(labelText: 'Product Price'),
            ),
            TextFormField(
              controller: controller.stock,
              decoration: const InputDecoration(labelText: 'Product Stock'),
            ),
            DropdownButtonFormField(
              value:
                  controller.type.text.isNotEmpty ? controller.type.text : null,
              decoration: const InputDecoration(labelText: 'Product Type'),
              items: AppData.categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                controller.type.value =
                    TextEditingValue(text: newValue.toString());
              },
            ),
            Obx(() {
              return controller.inputImageUrl.value != ''
                  ? Image.network(
                      controller.inputImageUrl.value,
                      width: 250,
                      height: 250,
                      fit: BoxFit.contain,
                    )
                  : Container();
            }),
            Obx(() {
              return ElevatedButton(
                onPressed:
                    controller.loading.value ? null : controller.uploadImage,
                child: controller.loading.value
                    ? const CircularProgressIndicator()
                    : const Text('Upload Image'),
              );
            }),
            ElevatedButton(
              onPressed: () {
                controller.updateProduct();
                Get.off(DashBoardScreen());
              },
              child: const Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
