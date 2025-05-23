import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                        child: Icon(
                          Icons.person,
                          size: 167.sp,
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
                onPressed: () {
                  if (nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a name'),
                      ),
                    );
                    return;
                  }
                  AddProfileToFirebase ref = AddProfileToFirebase(
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
