import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final address = TextEditingController();
  final phoneNumber = TextEditingController();
  final isAdmin = true;
  final favorites = <String>[].obs;
  final cart = <String>[].obs;

  void clearControllers() {
    name.clear();
    email.clear();
    password.clear();
    address.clear();
    phoneNumber.clear();
  }

  void signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name.text,
          'address': address.text,
          'phoneNumber': phoneNumber.text,
          'isAdmin': isAdmin,
          'favorites': favorites,
          'cart': cart,
        });
        Get.snackbar(
          'Success',
          'Registration successful',
          backgroundColor: Colors.green,
        );

        Get.toNamed('/verifyemail/');
        clearControllers();
      }
    } catch (e) {
      Get.snackbar(
        'Error:',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
