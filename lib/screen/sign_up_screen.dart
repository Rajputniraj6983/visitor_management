import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/controller/auth_controller.dart';
import 'package:untitled3/services/auth_services.dart';
import 'sign_in.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final ValueNotifier<bool> _isObscured = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const SizedBox(height: 24),
              _buildTextField(controller.textname, 'NAME', Icons.person),
              const SizedBox(height: 16),
              _buildTextField(controller.textEmail, 'EMAIL', Icons.email),
              const SizedBox(height: 16),
              _buildTextField(controller.textPassword, 'PASSWORD', Icons.lock),
              const SizedBox(height: 16),
              ValueListenableBuilder<bool>(
                valueListenable: _isObscured,
                builder: (context, isObscured, child) {
                  return _buildPasswordField(
                    controller.textconfirmpassword,
                    'CONFIRM PASSWORD',
                    isObscured,
                  );
                },
              ),
              const SizedBox(height: 40),
              _buildSignUpButton(controller),
              const SizedBox(height: 20),
              _buildLoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      cursorColor: Colors.deepOrangeAccent.shade100,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepOrangeAccent.shade100),
        labelText: label,
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
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool isObscured) {
    return TextField(
      cursorColor: Colors.deepOrangeAccent.shade100,
      controller: controller,
      obscureText: isObscured,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.deepOrangeAccent.shade100),
        suffixIcon: ValueListenableBuilder<bool>(
          valueListenable: _isObscured,
          builder: (context, value, child) {
            return IconButton(
              icon: Icon(value ? Icons.visibility_off : Icons.visibility, color: Colors.deepOrangeAccent.shade100),
              onPressed: () {
                _isObscured.value = !_isObscured.value;
              },
            );
          },
        ),
        labelText: label,
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
  }

  Widget _buildSignUpButton(AuthController controller) {
    return InkWell(
      onTap: () {
        AuthServices.authServices.createAccountWithEmailAndPassword(
          controller.textEmail.text,
          controller.textPassword.text,
        );

        controller.textEmail.clear();
        controller.textname.clear();
        controller.textPassword.clear();
        controller.textconfirmpassword.clear();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.deepOrangeAccent.shade100,
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
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

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
            Get.to(SignIn(), transition: Transition.circularReveal);
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.deepOrangeAccent.shade100,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
