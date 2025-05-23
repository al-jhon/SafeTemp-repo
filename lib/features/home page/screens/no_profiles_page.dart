import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoProfilesPage extends StatelessWidget {
  const NoProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
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
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 643.h,
            child: Column(
              children: [
                SizedBox(
                  height: 213.h,
                ),
                Icon(Icons.no_accounts,
                    size: 200.sp,
                    color: Theme.of(context).colorScheme.onSurface),
                SizedBox(
                  height: 112.h,
                ),
                SizedBox(
                  height: 60.h,
                  width: 295.w,
                  child: Text(
                    'Click the plus button in the bottom to add a person',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
