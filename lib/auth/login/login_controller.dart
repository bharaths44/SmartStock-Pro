import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartstock_pro/adminui/src/view/screens/admin_home_page/home_page_controller.dart';
import 'package:smartstock_pro/customerui/controller/product_controller.dart';
import 'package:smartstock_pro/customerui/view/screen/home_screen/home_controller.dart';

class LoginController extends GetxController {
  final ProductController controller = Get.find<ProductController>();
  final AdminPageController admindashboardController =
      Get.find<AdminPageController>();
  final DashBoardController dashboardController =
      Get.find<DashBoardController>();
  final email = TextEditingController();
  final password = TextEditingController();

  void clearControllers() {
    email.clear();
    password.clear();
  }

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // Get the user's document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      executeOnInitLogic();
      // Check if the user is an admin
      if ((userDoc.data() as Map<String, dynamic>)['isAdmin'] == true) {
        // User is an admin, proceed with login
        Get.offAllNamed('/adminhome/');
      } else {
        Get.offAllNamed('/customerhome/');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  void logout() async {
    dashboardController.initTabIndex();
    admindashboardController.initTabIndex();
    await FirebaseAuth.instance.signOut();
    clearControllers();
    Get.offAllNamed('/login/');
  }

  void forgotPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      Get.snackbar(
        'Success',
        'Password reset email sent. Please check your email.',
        backgroundColor: Colors.green,
      );
      clearControllers();
      Get.offAllNamed('/login/');
    } catch (e) {
      Get.snackbar(
        'Error:',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  void executeOnInitLogic() {
    controller.allProducts.clear();
    controller.fetchProducts();
    controller.fetchUsername();
  }
}
