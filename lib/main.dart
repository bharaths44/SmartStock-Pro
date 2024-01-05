import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:smartstock_pro/adminui/core/dependency.dart';
import 'package:smartstock_pro/adminui/src/view/screens/add_product/add_product.dart';
import 'package:smartstock_pro/adminui/src/view/screens/admin_home_page/dashboard.dart';
import 'package:smartstock_pro/adminui/src/view/screens/all_product_screen/all_products.dart';
import 'package:smartstock_pro/adminui/src/view/screens/all_product_screen/product_detail_screen.dart';
import 'package:smartstock_pro/auth/forgot_password/forgot_password_screen.dart';
import 'package:smartstock_pro/auth/login/login_screen.dart';
import 'package:smartstock_pro/auth/register/register_screen.dart';
import 'package:smartstock_pro/auth/verify_email/verify_email_view.dart';
import 'package:smartstock_pro/customerui/view/screen/home_screen/home_screen.dart';
import 'package:smartstock_pro/firebase_options.dart';

import 'customerui/view/screen/payment_screen/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyCreator.init();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      routes: {
        '/adminproductDetailScreen/': (context) => AdminProductDetailScreen(),
        '/allProductScreen/': (context) => AllProductScreen(),
        '/login/': (context) => LoginScreen(),
        '/verifyemail/': (context) => const VerifyEmailView(),
        '/forgot_password/': (context) => const ForgotPassWordScreen(),
        '/addProductScreen': (context) => AddProductScreen(),
        '/register/': (context) => const RegisterScreen(),
        '/adminhome/': (context) => DashBoardScreen(),
        '/customerhome/': (context) => HomeScreen(),
      },
      initialBinding: DashBoardControllerBinding(),
      home: LoginScreen(),
    );
  }
}
