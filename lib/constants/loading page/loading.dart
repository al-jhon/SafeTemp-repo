import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/constants/landing%20page/landing.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    Future.delayed(const Duration(seconds: 3), () async {
      await Firebase.initializeApp();
      if (!mounted) return; // Prevents navigation if the widget was disposed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Landing(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 410.5.h,
            ),
            SizedBox(
              height: 75.h,
              width: 261.w,
              child: Image.asset(
                  "assets/safetemp-high-resolution-logo-transparent.png"),
            ),
            SizedBox(
              height: 97.h,
            ),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
