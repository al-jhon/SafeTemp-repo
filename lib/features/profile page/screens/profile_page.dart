import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:safe_temp/constants/landing%20page/landing.dart';
import 'package:safe_temp/services/user_id.dart';
import 'package:safe_temp/widgets/my_appbar_for_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imageFile;
  String? _imageUrl;

  final picker = ImagePicker();

  Future<void> uploadImage() async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dpsqzjmqw/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'jzk00itl'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile!.path,
      ));

    final responce = await request.send();
    if (responce.statusCode == 200) {
      final responseData = await responce.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      setState(() {
        final url = jsonMap['url'];
        _imageUrl = url;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId())
          .update({'profilePicture': _imageUrl}).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile picture updated successfully!'),
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile picture: $error'),
          ),
        );
      });
    }
  }

  pickCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      setState(() {});
      uploadImage();
    }
  }

  pickGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      setState(() {});
      uploadImage();
    }
  }

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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Text(
                                                        'Choose Photo Source'),
                                                    content: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons
                                                                  .photo_library,
                                                              size: 40),
                                                          tooltip: 'Gallery',
                                                          onPressed: () async {
                                                            pickGallery();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.camera_alt,
                                                              size: 40),
                                                          tooltip: 'Camera',
                                                          onPressed: () async {
                                                            pickCamera();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ));
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 32.w),
                    //   child: SizedBox(
                    //     height: 50.h,
                    //     child: ElevatedButton(
                    //       onPressed: () async {},
                    //       style: ElevatedButton.styleFrom(
                    //         elevation: 4,
                    //         shadowColor: Theme.of(context).shadowColor,
                    //         backgroundColor:
                    //             Theme.of(context).colorScheme.primary,
                    //         foregroundColor:
                    //             Theme.of(context).colorScheme.onSurface,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(8.r),
                    //         ),
                    //       ),
                    //       child: Text(
                    //         "Change Password",
                    //         style: TextStyle(
                    //           fontSize: 24.sp,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
