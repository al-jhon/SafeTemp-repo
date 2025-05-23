import 'package:firebase_database/firebase_database.dart';

Future<String> getTemperature(String deviceID) async {
  DatabaseReference deviceRef = FirebaseDatabase.instance.ref(deviceID);
  DataSnapshot snapshot = await deviceRef.get();
  final data = snapshot.value as Map<dynamic, dynamic>?;

  if (data != null) {
    return data['temperature'];
  } else {
    return '0';
  }
}
