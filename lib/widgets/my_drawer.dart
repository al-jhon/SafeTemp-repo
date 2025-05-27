import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_temp/features/edit/screens/edit_page.dart';
import 'package:safe_temp/provider%20functions/my_navbar_state_provider.dart';
import 'package:safe_temp/provider%20functions/my_theme_provider.dart';
import 'package:safe_temp/services/user_email.dart';
import 'package:safe_temp/services/user_id.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<MyThemeProvider>().darkMode;

    final String userID = userId()!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Drawer(
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
              child: Column(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Row(
                        children: [
                          data['profilePicture'] == null
                              ? Icon(Icons.person,
                                  size: 50.sp,
                                  color:
                                      Theme.of(context).colorScheme.onSurface)
                              : Material(
                                  elevation: 4.0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: const CircleBorder(),
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            data['profilePicture']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: 23.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(data['lastName'] + ', ' + data['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 16.sp)),
                              Text(userEmail()!,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 13.sp)),
                            ],
                          )
                        ],
                      )),
                  ListTile(
                    leading: Icon(Icons.home,
                        color: Theme.of(context).colorScheme.onSurface),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20.sp),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();

                      if (context.read<MyNavbarStateProvider>().currentIndex !=
                          0) {
                        context
                            .read<MyNavbarStateProvider>()
                            .change(newCurrentIndex: 0);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add,
                        color: Theme.of(context).colorScheme.onSurface),
                    title: Text(
                      'Add Person',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20.sp),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();

                      if (context.read<MyNavbarStateProvider>().currentIndex !=
                          1) {
                        context
                            .read<MyNavbarStateProvider>()
                            .change(newCurrentIndex: 1);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit,
                        color: Theme.of(context).colorScheme.onSurface),
                    title: Text(
                      'Edit',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20.sp),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditPage(),
                          ));
                    },
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onSurface,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.nightlight_outlined,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20.sp,
                          ),
                        ),
                        Switch(
                          value: isDarkMode, // Bind the state variable
                          onChanged: (value) {
                            setState(() {
                              context
                                  .read<MyThemeProvider>()
                                  .change(newDarkMode: value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
