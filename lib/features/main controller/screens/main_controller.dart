import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_temp/features/add%20profile/screens/add_profile.dart';
import 'package:safe_temp/features/home%20page/screens/home_page.dart';
import 'package:safe_temp/provider%20functions/my_navbar_state_provider.dart';
import 'package:safe_temp/widgets/my_appbar.dart';
import 'package:safe_temp/widgets/my_bottom_nav_bar.dart';
import 'package:safe_temp/widgets/my_drawer.dart';

class MainController extends StatefulWidget {
  const MainController({super.key});

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  List<Widget> pages = [
    const HomePage(),
    const AddProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.watch<MyNavbarStateProvider>().currentIndex;

    return Scaffold(
        appBar: const MyAppbar(),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: pages[selectedIndex],
        ),
        drawer: const MyDrawer(),
        bottomNavigationBar: const MyBottomNavBar());
  }
}
