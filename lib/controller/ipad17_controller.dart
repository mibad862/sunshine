import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/config/app_config.dart';




class Ipad17Controller extends ChangeNotifier {
  bool canGoUpValue = false;
  bool canGoDownValue = false;

  bool canGoUpAccessible = false;
  bool canGoDownAccessible = false;

  bool isLoading = false;
  String errorMessage = '';



  void toggleCanGoUp() {
    canGoUpValue = !canGoUpValue;
    notifyListeners();
  }

  // Method to toggle canGoDown
  void toggleCanGoDown() {
    canGoDownValue = !canGoDownValue;
    notifyListeners();
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

          // Set accessibility based on initial values
          canGoUpAccessible = canGoUpValue;
          canGoDownAccessible = canGoDownValue;

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
}
