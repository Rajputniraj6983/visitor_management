import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/controller/register_controller.dart';
import 'package:untitled3/services/auth_services.dart';
import 'sign_in.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final ValueNotifier<bool> _isObscured = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.find();


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SizedBox(height: 40),
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
              'Register',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create your account',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView(
                children: [
                  _buildTextField(controller.txtName, 'NAME', Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(controller.textEmail, 'EMAIL', Icons.email),
                  const SizedBox(height: 16),
                  _buildTextField(controller.textPassword, 'PASSWORD', Icons.lock),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isObscured,
                    builder: (context, isObscured, child) {
                      return _buildPasswordField(
                        controller.txtConfirmPassword,
                        'CONFIRM PASSWORD',
                        isObscured,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  _buildSignUpButton(controller),SizedBox(height: 50),
                  _buildLoginPrompt(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      cursorColor: Colors.black,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        labelText: label,
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
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool isObscured) {
    return TextField(
      cursorColor: Colors.black,
      controller: controller,
      obscureText: isObscured,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.black),
        suffixIcon: ValueListenableBuilder<bool>(
          valueListenable: _isObscured,
          builder: (context, value, child) {
            return IconButton(
              icon: Icon(value ? Icons.visibility_off : Icons.visibility, color: Colors.black),
              onPressed: () {
                _isObscured.value = !_isObscured.value;
              },
            );
          },
        ),
        labelText: label,
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
  }

  /// **Sign Up Button**
  Widget _buildSignUpButton(RegisterController controller) {
    return InkWell(
      onTap: () async {
        await AuthServices.authServices.createAccountWithEmailAndPassword(
          controller.textEmail.text,
          controller.textPassword.text,
        );
        controller.textEmail.clear();
        controller.txtName.clear();
        controller.textPassword.clear();
        controller.txtConfirmPassword.clear();
        Get.offAll(SignIn(), transition: Transition.fade);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrangeAccent.shade100.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  /// **Login Redirect**
  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            Get.to(SignIn(), transition: Transition.fade);
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
