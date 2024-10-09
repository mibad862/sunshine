import 'package:flutter/material.dart';

class VisibilityController extends ChangeNotifier {
  bool isVisible = true;

  void toggleVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }
}
