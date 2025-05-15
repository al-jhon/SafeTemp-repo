import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_temp/features/main%20controller/screens/main_controller.dart';

class SignUpFirebase {
  final BuildContext context;
  final String email;
  final String password;
  final String name;
  final String lastName;

  SignUpFirebase({
    required this.email,
    required this.password,
    required this.context,
    required this.name,
    required this.lastName,
  });

  Future<void> signUpWithEmailAndPassword() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'lastName': lastName,
          'email': email,
        });

        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainController()),
            (route) => false);
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the loading dialog

      String errorMessage =
          'Sign up failed. Please try again.'; // Default error message

      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          errorMessage =
              'This email is already registered. Please use a different email.';
        } else if (e.code == 'invalid-email') {
          errorMessage =
              'The email address is not valid. Please enter a valid email.';
        } else {
          errorMessage = 'An unexpected error occurred: ${e.message}';
        }
      }

      // Display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
