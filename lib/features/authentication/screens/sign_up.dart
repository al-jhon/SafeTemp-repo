import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_temp/features/authentication/screens/sign_in.dart';
import 'package:safe_temp/features/authentication/services/sign_up_firebase.dart';
import 'package:safe_temp/special%20functions/upper_case.dart';
import 'package:safe_temp/widgets/auth_text_widget.dart';
import 'package:safe_temp/widgets/my_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  StringManipulator stringManipulator = StringManipulator();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                "Create account",
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
              child: const AuthTextWidget(text: "First Name"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: MyTextField(
                isPassword: false,
                controller: firstNameController,
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 27.w, right: 281.w),
              child: const AuthTextWidget(text: "Last Name"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: MyTextField(
                isPassword: false,
                controller: lastNameController,
              ),
            ),
            SizedBox(
              height: 9.h,
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
              height: 9.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 27.w, right: 234.w),
              child: const AuthTextWidget(text: "Confirm Password"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: MyTextField(
                isPassword: true,
                controller: confirmPasswordController,
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 95.w),
              child: Row(
                children: [
                  Text(
                    "Already have an account? ",
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
                              builder: (context) => const SignIn()));
                    },
                    child: Text(
                      "Sign in",
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
            SizedBox(
              height: 31.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: SizedBox(
                height: 50.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    //
                    final String firstName = stringManipulator
                        .toTitleCase(firstNameController.text.trim());
                    debugPrint("First Name: $firstName"); // Debug print

                    final lastName = stringManipulator
                        .toTitleCase(lastNameController.text.trim());
                    debugPrint("Last Name: $lastName"); // Debug print
                    //

                    if (firstName.isEmpty ||
                        lastName.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please fill in all fields",
                          ),
                        ),
                      );
                      return;
                    }
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Passwords do not match",
                          ),
                        ),
                      );
                      return;
                    }
                    if (passwordController.text.length < 6) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Password must be at least 6 characters",
                          ),
                        ),
                      );
                      return;
                    }
                    // Check for special character and uppercase letter
                    final password = passwordController.text;
                    final hasUppercase = password
                        .contains(RegExp(r'[A-Z]')); // Checks for uppercase
                    final hasSpecialCharacter = password.contains(RegExp(
                        r'[!@#$%^&*(),.?":{}|<>;]')); // Checks for special characters

                    if (!hasUppercase || !hasSpecialCharacter) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Password must contain at least one uppercase letter and one special character",
                          ),
                        ),
                      );
                      return;
                    }

                    // If all checks pass, navigate to MainController screen
                    SignUpFirebase signUpFirebase = SignUpFirebase(
                      context: context,
                      name: firstName,
                      lastName: lastName,
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    signUpFirebase.signUpWithEmailAndPassword();
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
                    "Create account",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
