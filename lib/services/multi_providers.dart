import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sunshine_app/controller/Vehicle_Movement_controller.dart';
import 'package:sunshine_app/controller/auth_controller.dart';
import 'package:sunshine_app/controller/brightness_controller.dart';
import 'package:sunshine_app/controller/customerResponse_controller.dart';
import 'package:sunshine_app/controller/datetime_controller.dart';
import 'package:sunshine_app/controller/driver_portal_controller.dart';
import 'package:sunshine_app/controller/home_controller.dart';
import 'package:sunshine_app/controller/ipad14_controller.dart';
import 'package:sunshine_app/controller/ipad15_controller.dart';
import 'package:sunshine_app/controller/ipad16_controller.dart';
import 'package:sunshine_app/controller/theme_controller.dart';
import 'package:sunshine_app/controller/visibility_controller.dart';

import '../controller/ipad16_three_controller.dart';
import '../controller/ipad16_two_controller.dart';
import '../controller/ipad17_controller.dart';


class MultiProviderClass {
  static List<SingleChildWidget> get providersList => [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => DriverPortalController()),
        ChangeNotifierProvider(create: (_) => DateTimeProvider()),
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider(create: (context) => BrightnessController()),
        ChangeNotifierProvider(create: (context) => VisibilityController()),
        ChangeNotifierProvider(create: (context) => CustomerController()),
        ChangeNotifierProvider(create: (context) =>VLineController()),
        ChangeNotifierProvider(create: (context) =>MetroLineController()),

        ChangeNotifierProvider(
            create: (context) => VehicleMovementController()),
       ChangeNotifierProvider(
            create: (context) => Ipad16Controller()),
    ChangeNotifierProvider(
            create: (context) => Ipad16TwoController(lineID: '1')),

    ChangeNotifierProvider(
            create: (context) => Ipad16ThreeController(direction: 'Up', startingStationId: '1')),

    ChangeNotifierProvider(
            create: (context) => Ipad17Controller()),

      ];
}
