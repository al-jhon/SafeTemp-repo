import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_temp/features/add%20profile/services/add_profile_to_firebase.dart';
import 'package:safe_temp/widgets/my_appbar_for_profile_page.dart';

class AddProfile2 extends StatefulWidget {
  final String? deviceId;
  const AddProfile2({super.key, required this.deviceId});

  @override
  State<AddProfile2> createState() => _AddProfile2State();
}

class _AddProfile2State extends State<AddProfile2> {
  TextEditingController nameController = TextEditingController();
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
    }
  }

  pickCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      setState(() {});
    }
  }

  pickGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbarForProfilePage(),
      body: ListView(
        children: [
          SizedBox(
            height: 21.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 327.h,
                color: Theme.of(context).colorScheme.secondary,
                child: Stack(children: [
                  Center(
                    child: Material(
                      elevation: 4.0,
                      clipBehavior: Clip.antiAlias,
                      shape: const CircleBorder(),
                      child: Container(
                        height: 250.h,
                        width: 250.w,
                        color: Theme.of(context).colorScheme.primary,
                        child: imageFile == null
                            ? Icon(
                                Icons.person,
                                size: 167.sp,
                              )
                            : Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 93.w, bottom: 32.h),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_a_photo_outlined,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 48.sp,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Choose Photo Source'),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.photo_library,
                                              size: 40),
                                          tooltip: 'Gallery',
                                          onPressed: () async {
                                            pickGallery();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.camera_alt,
                                              size: 40),
                                          tooltip: 'Camera',
                                          onPressed: () async {
                                            pickCamera();
                                            Navigator.of(context).pop();
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
            ),
          ),
          SizedBox(
            height: 18.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 143.h,
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Name',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        height: 46.h,
                        child: TextField(
                          controller: nameController,
                          // keyboardType: TextInputType.name
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.tertiary,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 52.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: SizedBox(
              height: 50.h,
              child: ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a name'),
                      ),
                    );
                    return;
                  }
                  if (imageFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select an image'),
                      ),
                    );
                    return;
                  }
                  showDialog(
                      context: context,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()));
                  await uploadImage();
                  Navigator.of(context).pop(); // Close the loading dialog
                  AddProfileToFirebase ref = AddProfileToFirebase(
                    profilePicture: _imageUrl!,
                    name: nameController.text.trim(),
                    deviceId: widget.deviceId!,
                    context: context,
                  );
                  ref.addProfileToFirebase();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  shadowColor: Theme.of(context).shadowColor,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
