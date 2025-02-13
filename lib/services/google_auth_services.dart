import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServices {
  GoogleAuthServices._();
  static GoogleAuthServices googleAuthServices = GoogleAuthServices._();

  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle()
   async{
     try
     {
       GoogleSignInAccount? account = await googleSignIn.signIn();
       GoogleSignInAuthentication authentication = await account!.authentication;
       AuthCredential credential = GoogleAuthProvider.credential(
         accessToken: authentication.accessToken,
         idToken: authentication.idToken,
       );
       UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
     }catch(e)
     {
       Get.snackbar("Google Sign in Failed", e.toString());
       print(e.toString());
     }
   }
}