import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/features/home%20page/services/get_temperature.dart';

class PageViewScreen extends StatefulWidget {
  final String name;
  final String deviceId;
  const PageViewScreen({super.key, required this.name, required this.deviceId});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  bool _default = true; // Initialize with a default value
  String temperature = "0"; // Declare temperature as a state variable

  @override
  void initState() {
    super.initState();
    _initializeDefault();
    _initializeTemperature();
  }

  Future<void> _initializeTemperature() async {
    String temp = await getTemperature(widget.deviceId);
    setState(() {
      temperature = temp;
    });
  }

  Future<void> _initializeDefault() async {
    final snapshot = await FirebaseDatabase.instance
        .ref(widget.deviceId)
        .child('default')
        .get();
    if (snapshot.exists) {
      setState(() {
        _default = snapshot.value as bool;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference deviceRef =
        FirebaseDatabase.instance.ref(widget.deviceId);
    // deviceRef.onValue.listen((event) {
    //   final data = event.snapshot.value as Map<dynamic, dynamic>?;

    //   if (data != null) {
    //     setState(() {
    //       // Assuming the values exist and have correct types
    //       temperature = data['temperature'].toString();
    //     });
    //   }
    // });

    return SafeArea(
        child: ListView(
      children: [
        SizedBox(
          height: 21.h,
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
            clipBehavior:
                Clip.antiAlias, // Ensures shadow respects border radius
            child: Container(
              height: 438.h,
              width: 370.w,
              color: Theme.of(context).colorScheme.secondary,
              child: Column(
                children: [
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 19.w,
                      ),
                      Material(
                        color: Theme.of(context).colorScheme.primary,
                        elevation: 4.0,
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                          height: 145.h,
                          width: 145.w,
                          child: Center(
                            child: Container(
                              height: 104.h,
                              width: 104.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://scontent.fcgy3-2.fna.fbcdn.net/v/t1.15752-9/485732384_1331181884870361_3552085794045203646_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=9f807c&_nc_ohc=wHGTNNpLZ_4Q7kNvwGbb3Fb&_nc_oc=Adl_AHKUzs3AFvznz2jGJrK43OK6pKVPhv6uywypovgI9sNkkaSWzGp4fG7TXGTozCQ&_nc_zt=23&_nc_ht=scontent.fcgy3-2.fna&oh=03_Q7cD2AGmvErcQe7FBLRyt1eNRvt_25QEoiIY8BbWyKBc856coA&oe=682F2D1B"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 11.w,
                      ),
                      Column(
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            widget.deviceId,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 99.h,
                  ),
                  Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                      height: 111.h,
                      width: 260.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            temperature, // Show temperature value dynamically
                            style: TextStyle(
                              color: double.parse(temperature) <= 39.0
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Colors.red,
                              fontSize: 75.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.thermostat_rounded,
                            size: 50.sp,
                            color: double.parse(temperature) <= 39.0
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Colors.red,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 103.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 32.w,
            ),
            SizedBox(
              height: 46.h,
              width: 145.w,
              child: ElevatedButton(
                onPressed: () {
                  // Update the value in Firebase
                  deviceRef.child('default').set(true);

                  setState(() {
                    _default = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  elevation: 4,
                  shadowColor: Theme.of(context).shadowColor,
                  backgroundColor: _default
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiaryContainer,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  "Default",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 60.w,
            ),
            SizedBox(
              height: 46.h,
              width: 145.w,
              child: ElevatedButton(
                onPressed: () {
                  // Update the value in Firebase
                  deviceRef.update({'default': false});

                  setState(() {
                    _default = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  elevation: 4,
                  shadowColor: Theme.of(context).shadowColor,
                  backgroundColor: !_default
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiaryContainer,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  "Heat Stroke",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
