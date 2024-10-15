import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/const/app_constants.dart';
import 'package:sunshine_app/models/jobs_model.dart';
import 'package:sunshine_app/services/api_service.dart';
import 'package:sunshine_app/view/ipad3.dart';

class Ipad4Controller extends ChangeNotifier {
  bool isLoading = false;
  JobsModel? latestJob;

  // get driver latest jobs
  Future<void> getDriverLatestJobs(
      {required String driverId, required BuildContext context}) async {
    isLoading = true;
    try {
      latestJob = null;
      final response = await apiService.callPostApi(
          apiPath: 'latestJobForDriver', apiData: {"driverId": driverId});

      log('getDriverLatestJobs called driverid $driverId res $response');

      if (response == null) {
        throw Exception('Invalid API response');
      }

      if (response["status"] == "success") {
        latestJob = JobsModel.fromJson(response["job"]);
      } else {
        log("something went wrong!!! $response");
      }
    } catch (e) {
      log('$e');
    }
    isLoading = false;
    notifyListeners();
  }

  // clockIn
  Future<void> clockIn(
      {required String driverId,
      required String clockStatus,
      required String jobId,
      required DateTime time,
      required BuildContext context}) async {
    isLoading = true;
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AppConstants.loader;
        },
      );

      final response =
          await apiService.callPostApi(apiPath: 'clockIn', apiData: {
        "driverId": driverId,
        "time": time.toString(),
        "clockStatus": clockStatus,
        "jobId": jobId
      });
      Navigator.pop(context);
      log('clockIn res $response');

      if (response == null) {
        throw Exception('Invalid API response');
      }

      if (response["status"] == "success") {
        toast("${response["message"]}");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserStatus(),
            ));
      } else {
        toast("${response["message"]}");
        log("something went wrong!!! $response");
      }
    } catch (e) {
      log('$e');
    }
    isLoading = false;
    notifyListeners();
  }
}
