import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/config/app_config.dart';
import '../models/ipad16_model.dart';
import 'package:logger/logger.dart';

class Ipad16TwoController extends ChangeNotifier {
  String lineId;

  Ipad16TwoController({required String lineID}) : lineId = lineID {
    fetchStations();
  }

  List<Station> stations = [];
  bool isLoading = false;
  String errorMessage = '';

  final logger = Logger();

  // Function to fetch station data from the API
  Future<void> fetchStations() async {
    const String apiUrl = "https://api.g00r.com.au/API/getStations";

    try {
      isLoading = true;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        errorMessage = 'Authentication token not found';
        logger.e('Authentication token not found'); // Log error
        return; // No need to call notifyListeners() here, as isLoading will be set to false later
      }

      logger.d("Line ID: $lineId");

      print("Line ID: $lineId");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "serverKey": AppConfig.serverKey,
          "lineId": lineId, // Use the lineId from the controller
        }),
      );

      print("Response $response.body");

      logger.i("Response: ${response.body}"); // Log the response

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          stations = (data['stations'] as List)
              .map((station) => Station.fromJson(station))
              .toList();
          errorMessage = '';
        } else {
          errorMessage = data['message'] ?? 'Failed to fetch stations';
          logger.w('Failed to fetch stations: $errorMessage'); // Log warning
        }
      } else {
        errorMessage = 'Failed to fetch stations: ${response.statusCode}';
        logger.e('API error: ${response.statusCode}'); // Log error
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
      logger.e('An exception occurred: $e'); // Log error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
