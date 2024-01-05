
import 'package:get/get.dart';
import 'package:smartstock_pro/auth/login/login_controller.dart';
import 'package:smartstock_pro/auth/register/register_controller.dart';
import 'package:smartstock_pro/customerui/controller/product_controller.dart';
import 'package:smartstock_pro/customerui/view/screen/home_screen/home_controller.dart';



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

class DependencyCreator {
  static init() {
    ProductControllerBinding().dependencies();
    DashBoardControllerBinding().dependencies();
    RegisterControllerBinding().dependencies();
    LoginControllerBinding().dependencies();
  }
}
