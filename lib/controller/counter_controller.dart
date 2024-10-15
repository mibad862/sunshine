import 'package:flutter/material.dart';

class CounterController with ChangeNotifier {
  final List<int> _counters = List.filled(7, 0);

  int getCounterValue(int index) => _counters[index];

  void incrementCounter(int index) {
    _counters[index] = (_counters[index] + 1) % 10;
    notifyListeners();
  }

  void decrementCounter(int index) {
    _counters[index] = (_counters[index] - 1 + 10) % 10;
    notifyListeners();
  }
}
