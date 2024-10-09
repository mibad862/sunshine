import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BrightnessController extends ChangeNotifier {
  double currentBrightness = 1.0;

  // Get the current brightness of the device
  Future<void> getCurrentBrightness() async {
    double brightness = await ScreenBrightness().current;
    currentBrightness = brightness;
    notifyListeners();
  }

  // Set the brightness of the device
  Future<void> setBrightness(double brightness) async {
    await ScreenBrightness().setScreenBrightness(brightness);
    currentBrightness = brightness;
    notifyListeners();
  }
}
