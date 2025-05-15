import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/features/authentication/screens/sign_up.dart';
import 'package:safe_temp/features/authentication/services/sign_in_firebase.dart';
import 'package:safe_temp/widgets/auth_text_widget.dart';
import 'package:safe_temp/widgets/my_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            SizedBox(
              height: 90.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 77.w),
              child: Image.asset(
                  "assets/safetemp-high-resolution-logo-transparent.png"),
            ),
            SizedBox(
              height: 26.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 27.w, right: 281.w),
              child: Text(
                "Welcome back",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 27.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 27.w, right: 281.w),
              child: const AuthTextWidget(text: "Email"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: MyTextField(
                isPassword: false,
                controller: emailController,
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 27.w, right: 281.w),
              child: const AuthTextWidget(text: "Password"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: MyTextField(
                isPassword: true,
                controller: passwordController,
              ),
            ),
            SizedBox(
              height: 255.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: SizedBox(
                height: 50.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      // Show error message if fields are empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please fill in all fields",
                          ),
                        ),
                      );
                      return;
                    }

                    SignInFirebase signIn = SignInFirebase(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      context: context,
                    );
                    signIn.signInWithEmailAndPassword();
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
                    "Sign in",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 31.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 95.w),
              child: Row(
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        foreground: Paint()
                          ..color = const Color.fromRGBO(112, 100, 249, 100),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
