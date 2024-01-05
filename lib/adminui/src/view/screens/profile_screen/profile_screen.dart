// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssp_admin_panel/widgets/customappbar.dart';

import '../../../../widgets/gridcard.dart';
import '../../../auth/login/login_controller.dart';

final LoginController loginController = Get.put(LoginController());

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Profile Screen",
      ),
      body: FutureBuilder<String>(
        future: getUserName(user),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            String username = snapshot.data ?? "Guest";
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 100, // adjust as needed
                        backgroundImage:
                            AssetImage('assets/images/profile_pic.png'),
                      ),
                      const SizedBox(height: 20), // adjust as needed
                      Text(
                        "Hello $username",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30, // adjust as needed
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    crossAxisCount: 2, // adjust as needed
                    children: [
                      GridCard(
                        action: loginController.logout,
                        icon: Icons.logout,
                        message: "Logout",
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

Future<String> getUserName(User? user) async {
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return userDoc['name'] ?? "Guest";
  }
  return "Guest";
}
