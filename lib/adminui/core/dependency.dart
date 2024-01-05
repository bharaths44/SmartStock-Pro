import 'package:get/get.dart';
import 'package:ssp_admin_panel/src/view/screens/admin_home_page/home_page_controller.dart';

import '../src/auth/login/login_controller.dart';
import '../src/auth/register/register_controller.dart';
import '../src/view/screens/all_product_screen/all_product_controller.dart';

class AllProductsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProductsController>(() => AllProductsController(),
        fenix: true);
  }
}
class DashBoardControllerBinding extends Bindings {
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
class DependencyCreator {
  static init() {
    AllProductsControllerBinding().dependencies();
    DashBoardControllerBinding().dependencies();
    RegisterControllerBinding().dependencies();
    LoginControllerBinding().dependencies();
  }
}
