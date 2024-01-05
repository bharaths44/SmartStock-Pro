import 'package:get/get.dart';
import 'package:smartstock_pro/adminui/src/view/screens/admin_home_page/home_page_controller.dart';
import 'package:smartstock_pro/customerui/controller/product_controller.dart';
import 'package:smartstock_pro/customerui/view/screen/home_screen/home_controller.dart';


import '../../auth/login/login_controller.dart';
import '../../auth/register/register_controller.dart';
import '../src/view/screens/all_product_screen/all_product_controller.dart';

class AllProductsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProductsController>(() => AllProductsController(),
        fenix: true);
  }
}
class AdminPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPageController>(() => AdminPageController(), fenix: true);
  }
}

class RegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
  
}

class ProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
  }
}

class DashBoardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController(), fenix: true);
  }
}


class DependencyCreator {
  static init() {
    AllProductsControllerBinding().dependencies();
    DashBoardControllerBinding().dependencies();
    RegisterControllerBinding().dependencies();
    LoginControllerBinding().dependencies();
    AdminPageControllerBinding().dependencies();
    ProductControllerBinding().dependencies();
  }
}
