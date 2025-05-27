import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/services/user_id.dart';

class MyShowModalBottomSheet extends StatefulWidget {
  final String profileUID;
  const MyShowModalBottomSheet({super.key, required this.profileUID});

  @override
  State<MyShowModalBottomSheet> createState() => _MyShowModalBottomSheetState();
}

class _MyShowModalBottomSheetState extends State<MyShowModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        clipBehavior: Clip.antiAlias,
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId())
                  .collection('profiles')
                  .doc(widget.profileUID)
                  .collection('logs')
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No logs available',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final log = snapshot.data!.docs[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(20.r),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          color: Theme.of(context).colorScheme.secondary,
                          child: ListTile(
                            title: Text("${log['temperature']}°C",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface)),
                            subtitle: Text(log['formatted_time'],
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant)),
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
                                    .doc(widget.profileUID)
                                    .collection('logs')
                                    .doc(log.id)
                                    .delete()
                                    .then((_) {
                                  
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Failed to delete profile: $error'),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ));
  }
}
