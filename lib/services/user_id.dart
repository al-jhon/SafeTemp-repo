import 'package:firebase_auth/firebase_auth.dart';

String? userId() {
  final user = FirebaseAuth.instance.currentUser!;

  return user.uid;
}