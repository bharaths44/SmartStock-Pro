// ignore_for_file: use_build_context_synchronously


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smartstock_pro/auth/login/login_controller.dart';
import 'package:smartstock_pro/customerui/controller/firebase_auth.dart';
import 'package:smartstock_pro/customerui/view/screen/profile_screen/orders.dart';
import 'package:smartstock_pro/widgets/gridcard.dart';

final LoginController loginController = Get.put(LoginController());

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(13, 41, 71,1),
        title: const Text("Profile Screen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w300,
            )),
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
                      GridCard(
                        message: "Orders",
                        action: () {
                          Get.to(() => OrderScreen());
                        },
                        icon: Icons.shopping_cart,
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
