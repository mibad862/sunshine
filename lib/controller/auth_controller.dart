import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/const/app_constants.dart';
import 'package:sunshine_app/services/api_service.dart';
import 'package:sunshine_app/view/ipad3.dart';

class AuthController extends ChangeNotifier {
  int wrongAttempts = 0;

  // get all drivers
  Future<void> loginDriver(
      {required String driverId,
      required String pin,
      required BuildContext context}) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AppConstants.loader;
        },
      );

      final response = await apiService.callPostApi(
          apiPath: 'login.php', apiData: {"driverId": driverId, "pin": pin});

      log('login api called driverid $driverId pin $pin $response');
      Navigator.pop(context);

      if (response == null) {
        throw Exception('Invalid API response');
      }
      if (response["status"] == "success") {
        log('status success save token!!!!');
        toast(response['message']);

        await setValue("auth_token", response['authToken']);
        await setValue("driver_id", driverId);
        wrongAttempts = 0;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const UserStatus()));
      } else {
        toast("${response["message"]}");
        checkPassword(driverId: driverId, context: context);
      }
    } catch (e) {
      log('$e');
    }
  }

// check wrong attempts
  void checkPassword(
      {required String driverId, required BuildContext context}) async {
    // If password is wrong, increment the counter
    log('before wrong pass : $wrongAttempts');

    wrongAttempts++;

    log('after wrong pass : $wrongAttempts');

    if (wrongAttempts >= 2) {
      //hit lock api
      log('hit lock driver api :');

      lockOut(driverId: driverId, context: context);
      wrongAttempts = 0;
    }
  }

  // Lock out vehicle
  Future<void> lockOut(
      {required String driverId, required BuildContext context}) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AppConstants.loader;
        },
      );

      final response = await apiService
          .callPostApi(apiPath: 'lockDriver', apiData: {"driverId": driverId});

      log('login api called driverid $driverId $response');
      Navigator.pop(context);

      if (response == null) {
        throw Exception('Invalid API response');
      }
      // if (response["status"] == "success") {
      //   toast(response['message']);
      // } else {
      //   toast("${response["message"]}");
      // }
    } catch (e) {
      log('$e');
    }
  }
}
