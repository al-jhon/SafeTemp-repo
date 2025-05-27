import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/services/time.dart';
import 'package:safe_temp/services/user_id.dart';
import 'package:safe_temp/widgets/my_show_modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

class PageViewScreen extends StatefulWidget {
  final String profileUID;
  final String profilePicture;
  final String name;
  final String deviceId;
  const PageViewScreen(
      {super.key,
      required this.name,
      required this.deviceId,
      required this.profilePicture,
      required this.profileUID});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  late StreamSubscription<DatabaseEvent> _tempSubscription;
  String temperature = "0";
  bool _default = true;
  double timeDouble = 0.0;
  double timeFirebase = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeDefault();
    _startTemperatureListener();
  }

  void _startTemperatureListener() {
    _tempSubscription = FirebaseDatabase.instance
        .ref(widget.deviceId)
        .child('temperature')
        .onValue
        .listen((event) {
      final tempValue = event.snapshot.value;
      if (tempValue != null) {
        final tempDouble = double.tryParse(tempValue.toString());
        if (tempDouble != null && mounted) {
          setState(() {
            temperature = tempDouble.toStringAsFixed(1);
          });
        }
      }
      final phTime = DateTime.now().toUtc().add(const Duration(hours: 8));
      final formatted = DateFormat('yyyy-MM-dd – hh:mm a').format(phTime);

      FirebaseFirestore.instance
          .collection('users')
          .doc(userId())
          .collection('profiles')
          .doc(widget.profileUID)
          .collection("logs")
          .add({
        'temperature': temperature,
        'timestamp': phTime,
        'formatted_time': formatted, // optional for human-readable string
      });
    });
  }

  Future<void> _initializeDefault() async {
    final snapshot = await FirebaseDatabase.instance
        .ref(widget.deviceId)
        .child('default')
        .get();
    if (snapshot.exists && mounted) {
      setState(() {
        _default = snapshot.value as bool;
      });
    }
  }

  @override
  void dispose() {
    _tempSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference deviceRef =
        FirebaseDatabase.instance.ref(widget.deviceId);

    return SafeArea(
      child: ListView(
        children: [
          SizedBox(height: 21.h),
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
                height: 438.h,
                width: 370.w,
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  children: [
                    SizedBox(height: 13.h),
                    Row(
                      children: [
                        SizedBox(width: 19.w),
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
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: widget.profilePicture != ""
                                        ? NetworkImage(widget.profilePicture)
                                        : const AssetImage(
                                            'assets/default_profile.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 11.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            StreamBuilder<DateTime>(
                              stream: philippineTimeStream(widget.deviceId),
                              builder: (context, snapshot) {
                                timeDouble = snapshot.hasData
                                    ? snapshot.data!.hour.toDouble() +
                                        snapshot.data!.minute / 100.0
                                    : 0.0;
                                // final time = snapshot.hasData
                                //     ? "${snapshot.data!.hour.toString().padLeft(2, '0')}:${snapshot.data!.minute.toString().padLeft(2, '0')}"
                                //     : "--:--";

                                timeFirebase = getFirebaseTime();

                                return timeDouble >= timeFirebase &&
                                        timeDouble <= timeFirebase + 0.01
                                    ? Text(
                                        "Online",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                      )
                                    : Text(
                                        "Offline",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                        SizedBox(width: 30.w),
                        IconButton(
                          icon: Icon(Icons.book,
                              size: 30.sp,
                              color: Theme.of(context).colorScheme.onSurface),
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30.r),
                                  ),
                                ),
                                context: context,
                                builder: (context) => MyShowModalBottomSheet(
                                      profileUID: widget.profileUID,
                                    ));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 99.h),
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
                              temperature,
                              style: TextStyle(
                                color: double.parse(temperature) <= 37.0
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Colors.red,
                                fontSize: 75.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.thermostat_rounded,
                              size: 50.sp,
                              color: double.parse(temperature) <= 37.0
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 103.h),
          Row(
            children: [
              SizedBox(width: 32.w),
              SizedBox(
                height: 46.h,
                width: 145.w,
                child: ElevatedButton(
                  onPressed: () {
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
              SizedBox(width: 60.w),
              SizedBox(
                height: 46.h,
                width: 145.w,
                child: ElevatedButton(
                  onPressed: () {
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
      ),
    );
  }
}
