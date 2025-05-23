import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:safe_temp/features/add%20profile/screens/add_profile_2.dart';

class ScanDeviceId {
  final BuildContext context;
  final String deviceId;

  ScanDeviceId({required this.deviceId, required this.context});

  Future<void> findDeviceId() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(deviceId);
    try {
      showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));

      final snapshot = await ref.get();

      if (snapshot.exists) {
        Navigator.pop(context); // Close the loading dialog
        // Device ID found
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddProfile2(
              deviceId: deviceId,
            ),
          ),
        );
      } else {
        Navigator.pop(context); // Close the loading dialog
        // Device ID not found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Device ID not found!')),
        );
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not Found!')),
      );
    }
  }
}
