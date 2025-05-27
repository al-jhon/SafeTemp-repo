import 'package:firebase_database/firebase_database.dart';

double firebaseTime = 0.0;

Future<double> fetchTimeFirebase(String deviceID) async {
  final deviceRef = FirebaseDatabase.instance.ref(deviceID);
  final timeSnapshot = await deviceRef.child("time").get();
  if (timeSnapshot.exists) {
    firebaseTime = (timeSnapshot.value as num).toDouble();
  } else {
    firebaseTime = 0.0;
  }
  return firebaseTime;
}

double getFirebaseTime() {
  return firebaseTime;
}

Stream<DateTime> philippineTimeStream(String deviceId) async* {
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield DateTime.now().toUtc().add(const Duration(hours: 8));
    fetchTimeFirebase(deviceId);
  }
}
