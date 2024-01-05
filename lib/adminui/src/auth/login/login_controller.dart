import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ssp_admin_panel/src/view/screens/admin_home_page/home_page_controller.dart';

class LoginController extends GetxController {
  final AdminPageController dashboardController =
      Get.find<AdminPageController>();
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

      // Check if the user is an admin
      if ((userDoc.data() as Map<String, dynamic>)['isAdmin'] == true) {
        // User is an admin, proceed with login
        Get.offAllNamed('/home/');
      } else {
        // User is not an admin, show error message
        Get.snackbar(
          'Error',
          'You are not an admin.',
          backgroundColor: Colors.red,
        );
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
    await FirebaseAuth.instance.signOut();
    clearControllers();
    dashboardController.initTabIndex();
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
    // controller.fetchProducts();
    // controller.fetchUsername();
  }
}
