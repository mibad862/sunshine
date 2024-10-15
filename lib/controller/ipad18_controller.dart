import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/config/app_config.dart';
import 'package:sunshine_app/models/ipad18_model.dart';

class Ipad18Controller with ChangeNotifier {
  Ipad18Model? callOutData;
  bool isLoading = false;
  String errorMessage = '';
  int paxCounter = 0;

  Future<void> fetchCallOutData() async {
    isLoading = true;
    notifyListeners();

    const url = 'https://api.g00r.com.au/API/emergencyCallOutGetData';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    String? driverId = prefs.getString('driver_id');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "serverKey": AppConfig.serverKey,
          "driverId": driverId,
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        callOutData = Ipad18Model.fromJson(responseData['Data']);

        paxCounter = int.parse(callOutData!.paxCount ?? "");
        
        print("CALL OUT $callOutData");
        
        print("AAAA ${callOutData?.emergencyCallOutId}");
        print("BBBB ${callOutData?.startingStation}");
        print("CCCC ${callOutData?.destinationStation}");
        print("DDDD ${callOutData?.lineName}");
        print("EEEE ${callOutData?.nextStation}");
        print("FFFF ${callOutData?.nextStationId}");
        print("GGGG ${callOutData?.nextStationId}");
        print("HHHH ${callOutData?.stoppingPattern}");
        print("IIII ${callOutData?.paxCount}");

        errorMessage = '';
      } else {
        errorMessage = responseData['message'] ?? 'Error fetching data';
      }
    } catch (error) {
      errorMessage = 'Failed to fetch data. Please try again later. $error';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> arrivedStation(String emerCallOutId, String nextStaId) async {
    isLoading = true;
    notifyListeners();

    print("Emer $emerCallOutId");
    print("Emer $nextStaId");


    const url = 'https://api.g00r.com.au/API/arrivedStation';
    var body = {
      "serverKey": AppConfig.serverKey,
      // Replace with your server key
      "emergencyCallOutId": emerCallOutId,
      // Replace with dynamic values
      "nextStationId": nextStaId,
      // Replace with dynamic values
      "paxCount": paxCounter,
      // Replace with the paxCounter or other variable
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200 && responseData['status'] == 'success') {
        Fluttertoast.showToast(msg: "Station Arrived Successfully");

        await fetchCallOutData();
      } else {
        errorMessage = responseData['message'] ?? 'Error arriving at station';
      }
    } catch (error) {
      errorMessage = 'Failed to complete request. Please try again later.';
    }

    isLoading = false;
    notifyListeners();
  }


  Future<void> endTrip(String emerCallOutId) async {
    isLoading = true;
    notifyListeners();

    const url = 'https://api.g00r.com.au/API/endTrip';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    String? driverId = prefs.getString('driver_id');

    DateTime now = DateTime.now();

    // Format the current time as "yyyy-MM-dd HH:mm:ss"
    String formattedCurrentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "serverKey": AppConfig.serverKey,
          "emergencyCallOutId": emerCallOutId,
          "driverId": driverId,
          "currentTime": formattedCurrentTime, // include pax count if needed
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        // Handle successful response
        
        Fluttertoast.showToast(msg: responseData['message']);
        print('Trip ended successfully');
      } else {
        // Handle error message from API
        errorMessage = responseData['message'] ?? 'Error ending trip';
      }
    } catch (error) {
      errorMessage = 'Failed to end trip. Please try again later. $error';
    }

    isLoading = false;
    notifyListeners();
  }


  // Method to increment pax count
  void incrementPaxCount() {
    paxCounter++;
    notifyListeners();
  }

  // Method to decrement pax count, ensuring it doesn't go below 0
  void decrementPaxCount() {
    if (paxCounter > 0) {
      paxCounter--;
    } else {
      Fluttertoast.showToast(msg: "Pax Count Cannot be less than 0");
    }
    notifyListeners();
  }
}
