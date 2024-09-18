import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
@injectable
class RegisterRemoteDataSource {
  Future<void> registerWithFirebase(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        print("User created: ${user.uid}");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (e) {
      rethrow;
    }
  }

}