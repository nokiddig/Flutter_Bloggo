import 'package:firebase_auth/firebase_auth.dart';

Future<bool> registerWithEmail(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    print('User registered with UID: ${user?.uid}');
  } catch (e) {
    print('Error registering user: $e');
    return false;
  }
  return true;
}
