import 'package:firebase_auth/firebase_auth.dart';
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
}
