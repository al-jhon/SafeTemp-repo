import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/features/add%20profile/services/scan_device_id.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  TextEditingController deviceIdController = TextEditingController();

  @override
  void dispose() {
    deviceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 250.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Material(
              elevation: 4.0,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              child: Container(
                height: 111.h,
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Device ID',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        height: 46.h,
                        child: TextField(
                          controller: deviceIdController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
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
            height: 76.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: SizedBox(
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  if (deviceIdController.text.trim() != "") {
                    ScanDeviceId(
                      context: context,
                      deviceId: deviceIdController.text.trim(),
                    ).findDeviceId();
                  } else if (deviceIdController.text.trim() == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a device ID'),
                      ),
                    );
                  }
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
                  "Find Device",
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
