import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/const/app_constants.dart';
import 'package:sunshine_app/models/driver_status_model.dart';
import 'package:sunshine_app/models/jobs_model.dart';
import 'package:sunshine_app/services/api_service.dart';

class DriverPortalController extends ChangeNotifier {
  bool isLoading = false;
  DriverStatusModel? driverStatusModel;
  List<JobsModel> allJobs = [];

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

      log('getDriverStatus called driverid $driverId vehicleId $vehicleId $response');

      if (response == null) {
        throw Exception('Invalid API response');
      }
      // driverStatusModel = DriverStatusModel.fromJson(response);

      if (response["status"] == "success") {
        driverStatusModel =
            DriverStatusModel.fromJson(response["driver_status"]);
      } else {
        log("something went wrong!!! $response");
      }
    } catch (e) {
      log('$e');
    }
    isLoading = false;
    notifyListeners();
  }

  // get driver jobs
  Future<void> getDriverJobs(
      {required String driverId, required BuildContext context}) async {
    isLoading = true;
    try {
      final response = await apiService.callPostApi(
          apiPath: 'jobsForDriver', apiData: {"driverId": driverId});

      log('getDriverJobs called driverid $driverId res $response');

      if (response == null) {
        throw Exception('Invalid API response');
      }

      if (response["status"] == "success") {
        allJobs = List.from(response["jobs"])
            .map((e) => JobsModel.fromJson(e))
            .toList();
      } else {
        log("something went wrong!!! $response");
      }
    } catch (e) {
      log('$e');
    }
    isLoading = false;
    notifyListeners();
  }

// take vehicle
  Future<void> takeVehicle(
      {required String driverId,
      required String vehicleId,
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
      final response =
          await apiService.callPostApi(apiPath: 'takeVehicle', apiData: {
        "driverId": driverId,
        "vehicleId": vehicleId,
        "currentTime": currentTime.toString()
      });
      getDriverStatus(
          driverId: driverId, vehicleId: vehicleId, context: context);
      Navigator.pop(context);
      log('takeVehicle called driverid $driverId res $response');

      if (response == null) {
        throw Exception('Invalid API response');
      }

      if (response["status"] == "success") {
        toast("${response["message"]}");
      } else {
        log("something went wrong!!! $response");
      }
    } catch (e) {
      log('$e');
    }
  }

// start break
  Future<void> startBreak(
      {required String driverId,
      required String vehicleId,
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
      final response = await apiService.callPostApi(
          apiPath: 'startBreak',
          apiData: {
            "driverId": driverId,
            "currentTime": currentTime.toString()
          });
      getDriverStatus(
          driverId: driverId, vehicleId: vehicleId, context: context);
      log('startBreak called driverid $driverId res $response');
      Navigator.pop(context);
      if (response == null) {
        throw Exception('Invalid API response');
      }

      if (response["status"] == "success") {
        toast("${response["message"]}");
      } else {
        toast("${response["message"]}");
      }
    } catch (e) {
      log('something went wrong!!! $e');
    }
  }

// end break
  Future<void> endBreak(
      {required String driverId,
      required String vehicleId,
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
      final response = await apiService.callPostApi(
          apiPath: 'endBreak',
          apiData: {
            "driverId": driverId,
            "currentTime": currentTime.toString()
          });
      getDriverStatus(
          driverId: driverId, vehicleId: vehicleId, context: context);
      log('endBreak called driverid $driverId res $response');
      Navigator.pop(context);
      if (response == null) {
        throw Exception('Invalid API response');
      }

      if (response["status"] == "success") {
        toast("${response["message"]}");
      } else {
        toast("${response["message"]}");
      }
    } catch (e) {
      log('something went wrong!!! $e');
    }
  }

// clock off
  Future<void> clockOff(
      {required String driverId,
      required String vehicleId,
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

      final response = await apiService.callPostApi(
          apiPath: 'clockOff',
          apiData: {
            "driverId": driverId,
            "currentTime": currentTime.toString()
          });
      getDriverStatus(
          driverId: driverId, vehicleId: vehicleId, context: context);
      log('clockOff called driverid $driverId res $response');
      Navigator.pop(context);
      if (response == null) {
        throw Exception('Invalid API response');
      }

      if (response["status"] == "success") {
        toast("${response["message"]}");
      } else {
        toast("${response["message"]}");
      }
    } catch (e) {
      log('something went wrong!!! $e');
    }
  }
}
