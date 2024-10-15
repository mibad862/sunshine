import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/const/app_constants.dart';
import 'package:sunshine_app/services/api_service.dart';
import 'package:sunshine_app/view/releasevehicle.dart';

class Ipad6Controller extends ChangeNotifier {
  // releaseVehicle
  Future<void> releaseVehicle(
      {required String driverId,
      required String vehicleId,
      required String location,
      required BuildContext context}) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AppConstants.loader;
        },
      );
      DateTime currentTime = DateTime.now();
      Map<String, dynamic> mapData = {
        "driverId": driverId,
        "vehicleId": vehicleId,
        "currentTime": currentTime.toString(),
        "location": location,
      };

      final response = await apiService.callPostApi(
          apiPath: 'releaseVehicle', apiData: mapData);

      log('driverPortalStatuses called driverid $driverId res $response');
      Navigator.pop(context);
      if (response == null) {
        throw Exception('Invalid API response');
      }

      if (response["status"] == "success") {
        toast("${response["message"]}");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Releasevehicle(),
            ));
      } else {
        toast("${response["message"]}");
        log("something went wrong!!! $response");
      }
    } catch (e) {
      log('$e');
    }
  }
}
