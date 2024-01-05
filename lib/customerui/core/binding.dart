
import 'package:get/get.dart';
import 'package:smartstock_pro/adminui/core/dependency.dart';

import 'package:smartstock_pro/auth/login/login_screen.dart';
import 'package:smartstock_pro/auth/register/register_screen.dart';
import 'package:smartstock_pro/customerui/view/screen/home_screen/home_screen.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: '/home/',
      page: () => HomeScreen(),
      binding: DashBoardControllerBinding(),
    ),
    GetPage(
      name: '/login/',
      page: () => LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: '/register/',
      page: () => const RegisterScreen(),
      binding: RegisterControllerBinding(),
    )
  ];
}
