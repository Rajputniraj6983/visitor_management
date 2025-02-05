import 'package:flutter/material.dart';
import 'package:untitled3/screen/my_register_screen.dart';
import 'package:untitled3/screen/sign_in.dart';
import 'package:untitled3/services/auth_services.dart';
class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthServices.authServices.getcurrentUser()==null)? SignIn(): MyRegisterScreen();
  }
}
