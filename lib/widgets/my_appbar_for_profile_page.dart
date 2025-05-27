import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppbarForProfilePage extends StatelessWidget
    implements PreferredSizeWidget {
  const MyAppbarForProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8.r),
        bottomRight: Radius.circular(8.r),
      ),
      child: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Center(
          child: Container(
            height: 46.h,
            width: 163.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/safetemp-high-resolution-logo-transparent.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
