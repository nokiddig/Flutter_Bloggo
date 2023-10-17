import 'package:firebase_auth/firebase_auth.dart';

Future<bool> registerWithEmail(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> signInWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();

  } catch (e){
    return false;
  }
  return true;
}

Future<bool> sendPasswordResetEmail(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } catch (e) {
    return false;
  }
  return true;
}
