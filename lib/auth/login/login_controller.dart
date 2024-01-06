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
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.',
            backgroundColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.',
            backgroundColor: Colors.red);
      } else if (e.code == 'user-disabled') {
        Get.snackbar('Error', 'This user has been disabled.',
            backgroundColor: Colors.red);
      } else if (e.code == 'too-many-requests') {
        Get.snackbar('Error', 'Too many requests. Try again later.',
            backgroundColor: Colors.red);
      } else if (e.code == 'operation-not-allowed') {
        Get.snackbar('Error', 'Operation not allowed.',
            backgroundColor: Colors.red);
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'The email address is not valid.',
            backgroundColor: Colors.red);
      } else if (e.code == 'account-exists-with-different-credential') {
        Get.snackbar('Error', 'The email is already in use by another account.',
            backgroundColor: Colors.red);
      } else if (e.code == 'credential-already-in-use') {
        Get.snackbar('Error', 'The account already exists.',
            backgroundColor: Colors.red);
      } else if (e.code == 'invalid-credential') {
        Get.snackbar('Error', 'Invalid credentials.',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
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
