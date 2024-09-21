import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/helper/shared_preferences.dart';

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
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential);

    _storeUserName(userCredential.user?.displayName);
    // Once signed in, return the UserCredential
    return userCredential;
  }

  void _storeUserName(String? fullName) async {
    if (fullName != null) {
      // Split the name by spaces and filter out any parts that contain numbers
      final nameParts = fullName.split(' ').where((part) =>
          RegExp(r'^[a-zA-Z]+$').hasMatch(part)).toList();

      String firstName = nameParts.isNotEmpty ? nameParts.first : '';
      String lastName = nameParts.length > 1 ? nameParts.last : '';

      // Store the first and last names in SharedPreferences
      await SharedPreferencesHelper.setData(
          key: 'FirstNameGoogle', value: firstName);
      await SharedPreferencesHelper.setData(key: 'LastNameGoogle', value: lastName);
    }
  }
}