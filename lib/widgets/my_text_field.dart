import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatefulWidget {
  final bool? isPassword;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.isPassword,
    required this.controller,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isPasswordVisible = false; // Tracks whether the password is visible

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword == true && !_isPasswordVisible,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.tertiary,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        suffixIcon: widget.isPassword == true
            ? GestureDetector(
                onLongPress: () {
                  // Show password on long press
                  setState(() {
                    _isPasswordVisible = true;
                  });
                },
                onLongPressUp: () {
                  // Hide password when long press is released
                  setState(() {
                    _isPasswordVisible = false;
                  });
                },
                child: Icon(
                  _isPasswordVisible
                      ? Icons.visibility // Open eye icon
                      : Icons.visibility_off, // Closed eye icon
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            : null, // No suffix icon if not a password field
      ),
    );
  }
}