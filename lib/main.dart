import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled3/controller/register_controller.dart';
import 'package:untitled3/controller/theme_controller.dart';
import 'package:untitled3/firebase_options.dart';
import 'package:untitled3/screen/my_register_screen.dart';
import 'package:untitled3/screen/sign_in.dart';

import 'services/auth_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  Get.put(RegisterController());
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Get.find<ThemeController>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: (AuthServices.authServices.getcurrentUser()==null)? SignIn(): MyRegisterScreen(),
    );
  }
}



