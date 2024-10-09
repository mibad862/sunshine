// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';

//service
// class VehicleMotionService {
//   static const double speedThreshold = 10; // km/h threshold to consider vehicle moving

//   Future<bool> get isVehicleMoving async {
//     final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     return position.speed > speedThreshold;
//   }
// }

//controller
// class VehicleState extends ChangeNotifier {
//   bool _isMoving = false;

//   bool get isMoving => _isMoving;

//   void updateMovementStatus(bool isMoving) {
//     _isMoving = isMoving;
//     notifyListeners();
//   }

//   Future<void> checkAndSetMovement() async {
//     final isMoving = await VehicleMotionService().isVehicleMoving;
//     updateMovementStatus(isMoving);
//   }
// }

//view
// late Timer _timer;

// @override
// void initState() {
//   super.initState();
//   _startCheckingMovement();
// }

// @override
// void dispose() {
//   _timer?.cancel();
//   super.dispose();
// }

// void _startCheckingMovement() {
//   _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//     context.read<VehicleState>().checkAndSetMovement();
//   });
// }