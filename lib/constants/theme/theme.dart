import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      onSurface: Colors.black, //for text color
      surface: Colors.white, //for background color
      primary: Color.fromRGBO(245, 186, 66, 1), //for button and selected button
      secondary: Color.fromRGBO(251, 245, 219, 1),// for container color
      tertiary: Colors.white, //for app bar color
      tertiaryContainer:
          Color.fromRGBO(217, 217, 217, 1), //for button that is not selected
      surfaceContainerLow: Color.fromRGBO(217, 217, 217, 1) //for bottom nav bar
      ),
  shadowColor: Colors.grey[100],
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    onSurface: Colors.white,
    surface: Color.fromRGBO(73, 73, 73, 1),
    primary: Color.fromRGBO(212, 161, 60, 1),
    secondary: Color.fromRGBO(178, 173, 150, 1),
    tertiary: Color.fromRGBO(150, 150, 150, 1),
    tertiaryContainer: Color.fromRGBO(129, 129, 129, 1),
    surfaceContainerLow: Color.fromRGBO(129, 129, 129, 1),
  ),
  shadowColor: const Color.fromRGBO(0, 0, 0, 25),
);
