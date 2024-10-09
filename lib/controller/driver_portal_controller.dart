import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sunshine_app/models/driver_status_model.dart';
import 'package:sunshine_app/services/api_service.dart';

class DriverPortalController extends ChangeNotifier {
  bool isLoading = false;
  DriverStatusModel? driverStatusModel;
  // get driver status
  Future<void> getDriverStatus(
      {required String driverId,
      required String vehicleId,
      required BuildContext context}) async {
    isLoading = true;
    try {
      final response = await apiService.callPostApi(
          apiPath: 'driverPortalStatuses',
          apiData: {"driverId": driverId, "vehicleId": vehicleId});

      log('driverPortalStatuses called driverid $driverId vehicleId $vehicleId $response');

      if (response == null) {
        throw Exception('Invalid API response');
      }
      // driverStatusModel = DriverStatusModel.fromJson(response);

      if (response["status"] == "success") {
      driverStatusModel = DriverStatusModel.fromJson(response["driver_status"]);
      } else {
        log("something went wrong!!! $response");
      }
    } catch (e) {
      log('$e');
    }
    isLoading = false;
    notifyListeners();
  }
}
