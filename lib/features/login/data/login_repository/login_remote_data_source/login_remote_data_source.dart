import 'package:chat_app/core/helper/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginRemoteDataSource {
  Future<void> loginWithFirebase({
    required String email,
    required String password,
  }) async {
    try {
      // Attempt to sign in with the provided email and password
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      } else {
        throw 'Authentication failed. Please try again.';
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // extractUserNameFromGoogleAccount(googleUser);
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }catch (e) {
      rethrow;
    }
  }


  void extractUserNameFromGoogleAccount(GoogleSignInAccount? googleUser) {
    String emailName = googleUser?.email ?? "";
    emailName = emailName.split("@").first;
    final emailNameWithoutNumbers = emailName.replaceAll(RegExp(r'\d'), '');
    SharedPreferencesHelper.setData(key: "FirstNameFromGoogleAccount", value: emailNameWithoutNumbers);
  }
}
