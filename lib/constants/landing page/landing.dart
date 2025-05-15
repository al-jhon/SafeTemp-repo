import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/features/authentication/screens/sign_up.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SizedBox(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 77.w, right: 77.w, top: 410.h, bottom: 410.h),
              child: Image.asset(
                  "assets/safetemp-high-resolution-logo-transparent.png"),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 664.h, left: 32.w, right: 32.w, bottom: 152.h),
              child: SizedBox(
                height: 80.h,
                width: 350.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      shadowColor: Theme.of(context).shadowColor,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: Text(
                      'Get Started!',
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w400),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
