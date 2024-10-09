import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeProvider with ChangeNotifier {
  String _currentDateTime = '';

  DateTimeProvider() {
    _currentDateTime = _formatCurrentDateTime();
    _updateTime();
  }

  String get currentDateTime => _currentDateTime;

  // Function to format date and time
  String _formatCurrentDateTime() {
    return DateFormat('HH:mm:ss - d MMM yyyy').format(DateTime.now());
  }

  // Function to update time every second
  void _updateTime() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _currentDateTime = _formatCurrentDateTime();
      notifyListeners(); // Notify listeners about the update
    });
  }
}
