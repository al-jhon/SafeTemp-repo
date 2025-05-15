import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _default = true;
  String temperature = '0'; // Declare temperature as a state variable

  clicked({required bool value}) {
    setState(() {
      _default = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference deviceRef =
        FirebaseDatabase.instance.ref().child('sensor');

    // Stream listener
    deviceRef.onValue.listen((event) {
      setState(() {
        temperature = event.snapshot.value.toString();
      });
    });

    return Scaffold(
      body: SafeArea(
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
                              "Brader",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              "12312412213",
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
                                fontSize: 75.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.thermostat_rounded,
                              size: 50.sp,
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
                    clicked(value: true);
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
                    FirebaseDatabase.instance
                        .ref()
                        .child('sensor')
                        .set({'temperature': 0});
                    clicked(value: false);
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
      )),
    );
  }
}
