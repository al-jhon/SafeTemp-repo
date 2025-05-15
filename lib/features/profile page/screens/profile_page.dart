import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/constants/landing%20page/landing.dart';
import 'package:safe_temp/services/user_id.dart';
import 'package:safe_temp/widgets/my_appbar_for_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppbarForProfilePage(),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Material(
                        elevation: 4.0, // Elevation for shadow
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          color: Theme.of(context).colorScheme.secondary,
                          height: 470.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 300.h,
                                child: Stack(children: [
                                  Center(
                                    child: Material(
                                      elevation: 4.0,
                                      shape: const CircleBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 250.h,
                                        width: 250.w,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: data['profilePicture'] == null
                                            ? Icon(
                                                Icons.person,
                                                size: 167.sp,
                                              )
                                            : Center(
                                              child: Material(
                                                elevation: 4.0,
                                                shape: const CircleBorder(),
                                                clipBehavior: Clip.antiAlias,
                                                child: SizedBox(
                                                  height: 167.h,
                                                  width: 167.w,
                                                  child: Image.network(
                                                      data['profilePicture'],
                                                      fit: BoxFit.cover,
                                                    ),
                                                ),
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 93.w, bottom: 50.h),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          size: 48.sp,
                                        ),
                                        onPressed: () {
                                          // Add your onPressed code here!
                                        },
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 17.w,
                                  ),
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Text(
                                  data['lastName'] + ', ' + data['name'],
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 17.w,
                                  ),
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Text(
                                  data['email'],
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            shadowColor: Theme.of(context).shadowColor,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 17.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });

                            await FirebaseAuth.instance.signOut();
                            Navigator.pop(context); // Close the loading dialog
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Landing()),
                                (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            shadowColor: Theme.of(context).shadowColor,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            "Log Out",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
