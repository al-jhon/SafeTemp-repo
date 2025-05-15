import 'package:flutter/material.dart';

class MyThemeProvider extends ChangeNotifier {
  bool darkMode;

  MyThemeProvider({this.darkMode = true});

  void change({required bool newDarkMode}) async {
    darkMode = newDarkMode;
    notifyListeners();
  }
}
