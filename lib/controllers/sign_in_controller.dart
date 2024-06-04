import 'package:firebase_auth/firebase_auth.dart';

Future<void> signInAnonymously() async {
  try {
    await FirebaseAuth.instance.signInAnonymously();
    print("Signed in anonymously");
  } catch (e) {
    print(e); // Handle error
  }
}
