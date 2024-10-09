import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class VehicleMovementController extends ChangeNotifier {
  bool _isVehicleMoving = false;

  bool get isVehicleMoving => _isVehicleMoving;

  void updateVehicleMovement(bool isMoving) {
  
    _isVehicleMoving = isMoving;
    notifyListeners();
  }
}
