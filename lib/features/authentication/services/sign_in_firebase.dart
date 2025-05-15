import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_temp/features/main%20controller/screens/main_controller.dart';

class SignInFirebase {
  final BuildContext context;
  final String email;
  final String password;

  SignInFirebase({required this.email, required this.password, required this.context});

  Future<void> signInWithEmailAndPassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // User is signed in
        Navigator.pop(context); // Close the loading dialog
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainController()),
            (route) => false);
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the loading dialog
      String errorMessage;

      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = 'Email is not registered.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password. Please try again.';
        } else {
          errorMessage = 'Sign in failed. Please try again.';
        }
      } else {
        errorMessage = 'An unexpected error occurred.';
      }

      // Display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
