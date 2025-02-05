import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/controller/theme_controller.dart';
import 'package:untitled3/screen/Help%20&%20Support.dart';
import 'package:untitled3/screen/sign_in.dart';
import 'package:untitled3/services/auth_services.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent.shade100,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.deepOrangeAccent.shade100, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: const Icon(Icons.person, size: 60, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "John Doe",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            "johndoe@example.com",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: const Icon(Icons.sunny, color: Colors.deepOrangeAccent),
                    title: const Text("Theme Mode"),
                    subtitle: const Text("Change your Theme"),
                    trailing: Obx(
                          () => Switch(
                        value: themeController.isDarkMode,
                        onChanged: (bool value) {
                          themeController.toggleTheme();
                        },
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.deepOrangeAccent),
                    title: const Text("Terms & Conditions"),
                    subtitle: const Text("Rules and Regulations"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed('/profile');
                    },
                  ),
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: const Icon(Icons.lock, color: Colors.deepOrangeAccent),
                    title: const Text("Privacy & Security"),
                    subtitle: const Text("Manage security settings"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed('/security');
                    },
                  ),
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: const Icon(Icons.help, color: Colors.deepOrangeAccent),
                    title: const Text("Help & Support"),
                    subtitle: const Text("Get help or contact support"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.to(Helpsupport(),transition: Transition.circularReveal);
                    },
                  ),
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Logout", style: TextStyle(color: Colors.red)),
                    onTap: () {
                      AuthServices.authServices.signout();
                      User? user = AuthServices.authServices.getcurrentUser();
                      if (user == null) {
                        Get.offAllNamed('/login');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'App Version: 1.0.0',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
