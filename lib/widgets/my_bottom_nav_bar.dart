import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_temp/provider%20functions/my_navbar_state_provider.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.watch<MyNavbarStateProvider>().currentIndex;
    return SafeArea(
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Theme.of(context)
            .colorScheme
            .surfaceContainerLow, // Background color
        currentIndex: selectedIndex,
        onTap: (value) => setState(() {
          context.read<MyNavbarStateProvider>().change(newCurrentIndex: value);
        }),
        selectedItemColor:
            Theme.of(context).colorScheme.primary, // Selected item color
        unselectedItemColor: Colors.black, // Unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Add Profile',
          ),
        ],
      ),
    );
  }
}
