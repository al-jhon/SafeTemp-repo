import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe_temp/features/home%20page/screens/no_profiles_page.dart';
import 'package:safe_temp/features/home%20page/screens/page_view_screen.dart';
import 'package:safe_temp/services/user_id.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final String uid = userId()!;
    String profileUID;

    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .collection("profiles")
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!streamSnapshot.hasData ||
                  streamSnapshot.data!.docs.isEmpty) {
                return const NoProfilesPage();
              }

              return PageView.builder(
                controller: PageController(initialPage: 0, viewportFraction: 1),
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final doc = streamSnapshot.data!.docs[index];
                  profileUID = doc.id;
                  return PageViewScreen(
                    profileUID: profileUID,
                    profilePicture: doc['profilePicture'],
                    name: doc['name'],
                    deviceId: doc['deviceId'],
                  );
                },
              );
            }));
  }
}
