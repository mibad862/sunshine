import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/const/app_constants.dart';
import 'package:sunshine_app/models/questions_model.dart';
import 'package:sunshine_app/services/api_service.dart';
import 'package:sunshine_app/view/odometer_screen.dart';

class Ipad7Controller extends ChangeNotifier {
  bool isLoading = false;
  List<QuestionModel> allQuestions = [];

  // get questions
  Future<void> getQuestions({required BuildContext context}) async {
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
          await apiService.callPostApi(apiPath: 'getQuestions', apiData: {});

      log('getQuestions res $response');
      Navigator.pop(context);
      if (response == null) {
        throw Exception('Invalid API response');
      }

      if (response["status"] == "success") {
        allQuestions = List.from(response["questions"])
            .map((e) => QuestionModel.fromJson(e))
            .toList();
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

  // submit answers
  Future<void> submitAnswers(
      {required String driverId,
      required String vehicleId,
      required DateTime currentTime,
      required String odometerReading,
      required String fuelSource,
      required String fuel,
      required String washed,
      required String dumbToilet,
      required String vaccum,
      required String windScreen,
      required String paintTyres,
      required String polishRims,
      required String cleanAC,
      required String washerFluid,
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
      Map<String, dynamic> mapData = {
        "driverId": driverId,
        "vehicleId": vehicleId,
        "currentTime": currentTime.toString(),
        "odometerReading": odometerReading,
        "fuelSource": fuelSource,
        "fuel": fuel,
        "washed": washed,
        "dumbToilet": dumbToilet,
        "vaccum": vaccum,
        "windScreen": windScreen,
        "paintTyres": paintTyres,
        "polishRims": polishRims,
        "cleanAC": cleanAC,
        "washerFluid": washerFluid,
      };
      log('submit answer payload : $mapData');
      final response = await apiService.callPostApi(
          apiPath: 'submitValues', apiData: mapData);

      log('submitAnswers res $response');

      if (response == null) {
        throw Exception('Invalid API response');
      }
      Navigator.pop(context);
      if (response["status"] == "success") {
        toast("${response["message"]}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OdometerScreen()),
        );
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
