import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sunshine_app/controller/Vehicle_Movement_controller.dart';
import 'package:sunshine_app/controller/visibility_controller.dart';

class VisibilityWrapper extends StatefulWidget {
  const VisibilityWrapper({super.key, required this.bodyScreen});
  final Widget bodyScreen;

  @override
  State<VisibilityWrapper> createState() => _VisibilityWrapperState();
}

class _VisibilityWrapperState extends State<VisibilityWrapper> {
  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      bool isMoving = event.x > 1.0 || event.y > 1.0 || event.z > 1.0;
      Provider.of<VehicleMovementController>(context, listen: false)
          .updateVehicleMovement(isMoving);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityController>(
      builder: (context, value, child) => Scaffold(
        body: Stack(
          children: [
            Visibility(
              visible: value.isVisible,
              child: widget.bodyScreen,
            ),
            Visibility(
              visible: !value.isVisible,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                color: Colors.black,
                child: IconButton(
                    onPressed: value.toggleVisibility,
                    icon: const Icon(
                      LineIcons.eye,
                      color: Colors.white,
                      size: 100,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
