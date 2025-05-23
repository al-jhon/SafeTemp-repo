import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe_temp/features/main%20controller/screens/main_controller.dart';
import 'package:safe_temp/services/user_id.dart';
import 'package:safe_temp/special%20functions/upper_case.dart';

class AddProfileToFirebase {
  final String name;
  final String deviceId;
  final BuildContext context;

  AddProfileToFirebase(
      {required this.name, required this.deviceId, required this.context});

  Future<void> addProfileToFirebase() async {
    try {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));

      StringManipulator stringManipulator = StringManipulator();
      String upperCasedName = stringManipulator.toTitleCase(name);

      String uID = userId()!;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uID)
          .collection('profiles')
          .add({
        'name': upperCasedName,
        'deviceId': deviceId,
        'createdAt': DateTime.now(),
      });

      Navigator.of(context).pop(); // Close the loading dialog

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainController(),
        ),
        (route) => false, // This condition removes all previous routes
      );
    } catch (e) {
      debugPrint('nag error');
      Navigator.of(context).pop(); // Close the loading dialog
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add profile: $e')),
      );
    }
  }
}
