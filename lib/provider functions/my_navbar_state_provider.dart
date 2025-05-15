import 'package:flutter/material.dart';

class MyNavbarStateProvider extends ChangeNotifier {
  int currentIndex;

  MyNavbarStateProvider({this.currentIndex = 0});

  void change({required int newCurrentIndex}) async {
    currentIndex = newCurrentIndex;
    notifyListeners();
  }
}
