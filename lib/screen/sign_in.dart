import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/controller/register_controller.dart';
import 'package:untitled3/screen/my_register_screen.dart';
import 'package:untitled3/services/auth_services.dart';
import 'sign_up_screen.dart';
TextEditingController txtEmail = TextEditingController();
TextEditingController txtPassword = TextEditingController();
class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final ValueNotifier<bool> _isObscured = ValueNotifier<bool>(true);
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.find();
    double screenWidth = MediaQuery.of(context).size.width;

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: EdgeInsets.only(top: 90, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Image.asset(
                  'assets/aaishwarya logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),SizedBox(height: 15),
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
              TextField(
                cursorColor: Colors.black,
                controller: txtEmail,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.black),
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<bool>(
                valueListenable: _isObscured,
                builder: (context, isObscured, child) {
                  return TextField(
                    cursorColor: Colors.black,
                    controller: txtPassword,
                    obscureText: isObscured,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          _isObscured.value = !_isObscured.value;
                        },
                      ),
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
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
              const SizedBox(height: 10),
              Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.1),
                      blurRadius: 1,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });
                            String response = await AuthServices.authServices
                                .signInWithEmailAndPassword(
                                    txtEmail.text,
                                    txtPassword.text);
                            User? user =
                                AuthServices.authServices.getcurrentUser();
                            if (user != null && response == "Success") {
                              Get.offAll(MyRegisterScreen(),
                                  transition: Transition.circularReveal);
                            } else {
                              Get.snackbar('Sign in failed !',
                                  'Email or password wrong');
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w400),
                          ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont have an account?',
                    style: TextStyle(
                        color: Colors.grey, fontSize: screenWidth * 0.05),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Get.to(SignUpScreen(),
                          transition: Transition.circularReveal);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.red, fontSize: screenWidth * 0.05),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
