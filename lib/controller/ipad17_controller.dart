import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/config/app_config.dart';

import '../view/ipad18.dart';

class Ipad17Controller extends ChangeNotifier {
  bool canGoUpValue = false;
  bool canGoDownValue = false;

  final TextEditingController supervisorController = TextEditingController();

  bool canGoUpAccessible = false;
  bool canGoDownAccessible = false;

  bool isLoading = false;
  String errorMessage = '';

  Color upButtonColor = Colors.yellow; // Initial color for UP button
  Color downButtonColor = Colors.yellow;

  String?
      upButtonValue; // String that will hold the value for UP ("UP" or null)
  String? downButtonValue;

  Color arriveNowButtonColor = Colors.yellow; // Initial color
  String? arrivedTime; // To store the current time

  String? destinationName;
  String? destinationId;

  void toggleCanGoUp() {
    canGoUpValue = !canGoUpValue;
    notifyListeners();
  }

  // Method to check destination and navigate

  // Method to toggle canGoDown
  void toggleCanGoDown() {
    canGoDownValue = !canGoDownValue;
    notifyListeners();
  }

  void onArriveNowPressed() {
    // Format the current time in "yyyy-MM-dd HH:mm:ss" format
    arrivedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    print("Arrived Time $arrivedTime");
    arriveNowButtonColor = Colors.green; // Change button color upon pressing
    notifyListeners(); // Notify listeners to update the UI
  }

  // Function to fetch direction status
  Future<void> fetchDirectionStatus(String startingStationId) async {
    const String apiUrl = "https://api.g00r.com.au/API/getDirectionStatus";
    final body = {
      "serverKey": AppConfig.serverKey,
      "startingStationId": startingStationId,
    };

    print("Station ID: $startingStationId");
    print("Request Body: ${jsonEncode(body)}");

    try {
      isLoading = true;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        errorMessage = 'Authentication token not found';
        isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      print("Response: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          canGoUpValue = data['canGoUp'] ?? false;
          canGoDownValue = data['canGoDown'] ?? false;

          // canGoUpAccessible = data['canGoUp'] ?? false;
          // canGoDownAccessible = data['canGoDown'] ?? false;

          upButtonColor = canGoUpValue ? Colors.yellow : Colors.grey;
          downButtonColor = canGoDownValue ? Colors.yellow : Colors.grey;

          // Set accessibility based on initial values
          // canGoUpAccessible = canGoUpValue;
          // canGoDownAccessible = canGoDownValue;

          notifyListeners();

          print("UP: $canGoUpAccessible");
          print("DOWN: $canGoDownAccessible");
        } else {
          errorMessage = data['message'] ?? 'Error fetching direction status';
          print("API Error Message: $errorMessage");
        }
      } else {
        errorMessage =
            'Failed to fetch direction status: ${response.statusCode}';
        print("HTTP Error: $errorMessage");
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
      print(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> departNow(
      String startingStation,
      String direction,
      String destinationStation,
      String lineId,
      String paxCount,
      List<Map<String, dynamic>> stoppingPattern,
      BuildContext context) async {
    const String apiUrl =
        "https://api.g00r.com.au/API/emerygencyCallOutDepartNow";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? driverId = prefs.getString('driver_id');
    String? customerId = prefs.getString('customerId');
    String? callOutTime = prefs.getString('callOutTime');

    print("Starting Station $startingStation");
    print("Arrived $arrivedTime");
    print("Direction $direction");
    print("Des Station $destinationStation");
    print("Line ID $lineId");
    print("Pax $paxCount");
    print("Stopping $stoppingPattern");

    String currentTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print("Current Time $currentTime");

    print("Driver ID: $driverId");
    print("Customer ID: $customerId");
    print("Call Out: $callOutTime");

    if (startingStation.isEmpty ||
        direction.isEmpty ||
        destinationStation.isEmpty ||
        lineId.isEmpty ||
        paxCount.isEmpty ||
        driverId == null ||
        customerId == null ||
        callOutTime == null ||
        arrivedTime == null) {
      errorMessage = 'Please ensure all fields are filled out.';

      Fluttertoast.showToast(msg: errorMessage);
      notifyListeners(); // Notify listeners to update the UI
      return; // Exit the method if validation fails
    }

    // Sample request body (replace these values with dynamic data)
    final Map<String, dynamic> body = {
      "serverKey": AppConfig.serverKey,
      "startingStation": startingStation,
      // Replace with actual value
      "direction": direction,
      // Replace with actual direction value
      "destinationStation": destinationStation,
      // Replace with actual destinationStation value
      "driverId": driverId,
      // Replace with actual driverId value
      "customer": customerId,
      // Replace with actual customer value
      "currentTime": currentTime,
      // Current local time
      "line": lineId,
      // Replace with actual line value
      "arrivedTime": arrivedTime,
      // Example arrivedTime 3 min from now
      "paxCount": paxCount,
      // Replace with actual paxCount value
      "callOutBeginTime": callOutTime,
      // Call out began 2 min ago
      "stoppingPattern": stoppingPattern
    };

    try {
      isLoading = true;
      notifyListeners();

      // Fetch token from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        errorMessage = 'Authentication token not found';
        isLoading = false;
        notifyListeners();
        return;
      }

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      // Handle response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          // Success, notify UI
          errorMessage = 'Emergency Call Out Submitted Successfully';
          print(errorMessage);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Ipad18()));
          notifyListeners();
        } else {
          // Show error message from API response
          errorMessage = data['message'] ?? 'Error submitting call out';
          print(errorMessage);
          notifyListeners();
        }
      } else {
        errorMessage = 'HTTP Error: ${response.statusCode}';
        print(errorMessage);
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
      print("errorMessage $e");
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Method to toggle UP button
  void toggleUpButton() {
    if (canGoUpValue) {
      // Only toggle if accessible
      if (upButtonValue == null) {
        upButtonValue = "UP"; // Change value to "UP"
        downButtonValue = null; // Reset DOWN value
        upButtonColor = Colors.green; // Change UP button color to green
        downButtonColor = Colors.yellow; // Change DOWN button color back to red
      }
    }
    notifyListeners(); // Notify UI to reflect the changes
  }

  void toggleDownButton() {
    if (canGoDownValue) {
      // Only toggle if accessible
      if (downButtonValue == null) {
        downButtonValue = "DOWN"; // Change value to "DOWN"
        upButtonValue = null; // Reset UP value
        downButtonColor = Colors.green; // Change DOWN button color to green
        upButtonColor = Colors.yellow; // Change UP button color back to red
      }
    }
    notifyListeners(); // Notify UI to reflect the changes
  }
}
