import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:logger/logger.dart';
import 'package:sunshine_app/config/app_config.dart';

class Ipad16ThreeController extends ChangeNotifier {
  String startingStationId;
  String direction;

  Ipad16ThreeController({
    required this.startingStationId,
    required this.direction,
  }) {
    fetchStations();
  }

  List<Ipad16ThreeModel> stations = [];
  bool isLoading = false;
  String errorMessage = '';
  final logger = Logger();

  String? selectedStationName;
  int? selectedStationId;

  // Function to fetch station data from the API
  Future<void> fetchStations() async {
    print("Direction : $direction");
    const String apiUrl =
        "https://api.g00r.com.au/API/destinationStation";

    try {
      isLoading = true;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        errorMessage = 'Authentication token not found';
        logger.e('Authentication token not found');
        return;
      }

      logger
          .d("Starting Station ID: $startingStationId, Direction: $direction");
      print("Direction : $direction");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "serverKey": AppConfig.serverKey,
          "startingStationId": startingStationId,
          "direction": direction,
        }),
      );

      logger.i("Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          stations = (data['stations'] as List)
              .map((station) => Ipad16ThreeModel.fromJson(station))
              .toList();
          errorMessage = '';
        } else {
          errorMessage = data['message'] ?? 'Failed to fetch stations';
          logger.w('Failed to fetch stations: $errorMessage');
        }
      } else {
        errorMessage = 'Failed to fetch stations: ${response.statusCode}';
        logger.e('API error: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
      logger.e('An exception occurred: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  // Function to select a station
  void selectStationName(String name) {
    selectedStationName = name; // Store the entire station object
    logger.i("Selected station Name: $selectedStationName ");
    print("$selectedStationName");
    notifyListeners(); // This should update the UI
  }

  void selectStationId(int id) {
    selectedStationId = id;
    logger.i("Selected station Id: $selectedStationId");
    print("$selectedStationId");
    notifyListeners(); // This should update the UI
  }
}


// Define the Station model class for deserialization
class Ipad16ThreeModel {
  final int? stationId;
  final int? lineId;
  final String? name;

  Ipad16ThreeModel({
    this.stationId,
    this.lineId,
    this.name,
  });

  factory Ipad16ThreeModel.fromJson(Map<String, dynamic> json) {
    return Ipad16ThreeModel(
      stationId: json['stationId'],
      lineId: json['lineId'],
      name: json['name'],
    );
  }
}
