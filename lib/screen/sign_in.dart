import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/controller/auth_controller.dart';
import 'package:untitled3/screen/my_register_screen.dart';
import 'package:untitled3/services/auth_services.dart';
import 'sign_up_screen.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final ValueNotifier<bool> _isObscured = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.2, left: 16, right: 16),
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Welcome Back ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(cursorColor: Colors.deepOrangeAccent.shade100,
                      controller: controller.textemail,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.deepOrangeAccent.shade100),
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(color: Colors.deepOrangeAccent.shade100),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isObscured,
                      builder: (context, isObscured, child) {
                        return TextField(cursorColor: Colors.deepOrangeAccent.shade100,
                          controller: controller.textpassword,
                          obscureText: isObscured,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.deepOrangeAccent.shade100),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscured ? Icons.visibility_off : Icons.visibility,
                                color: Colors.deepOrangeAccent.shade100,
                              ),
                              onPressed: () {
                                _isObscured.value = !_isObscured.value;
                              },
                            ),
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(color: Colors.deepOrangeAccent.shade100),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.deepOrangeAccent.shade100),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.deepOrangeAccent.shade100,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepOrangeAccent.shade100.withOpacity(0.5),
                            blurRadius: 1,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            String response = await AuthServices.authServices.signInWithEmailAndPassword(
                                controller.textemail.text, controller.textpassword.text);
                            User? user = AuthServices.authServices.getcurrentUser();
                            if (user != null && response == "Success") {
                              Get.to(MyRegisterScreen(), transition: Transition.circularReveal);
                            } else {
                              Get.snackbar('Sign in failed !', 'Email or password wrong');
                            }
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white, fontSize: screenWidth * 0.05, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account?',
                          style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.05),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Get.to(SignUpScreen(), transition: Transition.circularReveal);
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.deepOrangeAccent.shade100, fontSize: screenWidth * 0.05),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
