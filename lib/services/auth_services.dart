import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthServices extends GetxController{
  AuthServices._();
  AuthServices();

  static AuthServices authServices = AuthServices._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // account create0
  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Login In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  // sign out
  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }

    // current user
  User? getcurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      print("email: ${user.email}");
    }
    return user;
  }
}
