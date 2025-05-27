import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe_temp/features/home%20page/screens/no_profiles_page.dart';
import 'package:safe_temp/services/user_id.dart';
import 'package:safe_temp/widgets/my_appbar_for_profile_page.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppbarForProfilePage(),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(userId())
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
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = streamSnapshot.data!.docs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(doc['profilePicture']),
                      ),
                      title: Text(doc['name']),
                      subtitle: Text(doc['deviceId']),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(userId())
                              .collection("profiles")
                              .doc(doc.id)
                              .delete()
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Profile ${doc['name']} deleted successfully'),
                              ),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Failed to delete profile: $error'),
                              ),
                            );
                          });
                        },
                      ),
                    );
                  });
            }));
  }
}
