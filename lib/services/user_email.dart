import 'package:firebase_auth/firebase_auth.dart';

String? userEmail() {
  final user = FirebaseAuth.instance.currentUser!;

  return user.email;
}
