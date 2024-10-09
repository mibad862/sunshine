import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/models/dashboard_model.dart';
import 'package:sunshine_app/services/api_service.dart';

class HomeController extends ChangeNotifier {
  DashboardModel? dashboardData;
  bool isLoading = false;

  // get all drivers
  Future<void> getAllDrivers() async {
    try {
      isLoading = true;
      final currentTime = DateTime.now().toString();
      final response = await apiService.callPostApi(
          apiPath: 'dashboard',
          apiData: {"currentTime": currentTime, "vehicleId": 9});
      dashboardData = DashboardModel.fromJson(response);
      log('dashboard data : ${dashboardData!.drivers.length}');
    } catch (e) {
      log('$e');
    }
    isLoading = false;
    notifyListeners();
  }
}
