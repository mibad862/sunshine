// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:nb_utils/nb_utils.dart';
// import 'package:sunshine_app/config/app_config.dart';
// import '../models/ipad16_model.dart';
//
// class Ipad16Controller extends ChangeNotifier {
//
//   Ipad16Controller(){
//     fetchStations();
//     selectedAlphabet = 'A';
//   }
//
//   List<Station> stations = [];
//   List<Station> filteredStations = []; // List to hold filtered stations
//   bool isLoading = false;
//   String errorMessage = '';
//   String selectedAlphabet = '';
//
//   void changeColor({required String selectedValue}) {
//     selectedAlphabet = selectedValue;
//     filterStations(); // Filter stations when a new alphabet is selected
//     notifyListeners();
//   }
//
//   // Function to fetch station data from the API
//   Future<void> fetchStations() async {
//     final String apiUrl = "https://api.g00r.com.au/API/getStations";
//
//     try {
//       isLoading = true;
//       notifyListeners();
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('auth_token');
//
//       if (token == null) {
//         errorMessage = 'Authentication token not found';
//         isLoading = false;
//         notifyListeners();
//         return;
//       }
//
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({
//           "serverKey": AppConfig.serverKey,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           stations = (data['stations'] as List)
//               .map((station) => Station.fromJson(station))
//               .toList();
//           filterStations(); // Initial filter based on default value
//           errorMessage = '';
//         } else {
//           errorMessage = data['message'] ?? 'Failed to fetch stations';
//         }
//       } else {
//         errorMessage = 'Failed to fetch stations: ${response.statusCode}';
//       }
//     } catch (e) {
//       errorMessage = 'An error occurred: $e';
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // Method to filter stations based on the selected alphabet
//   void filterStations() {
//     if (selectedAlphabet.isEmpty) {
//       filteredStations = stations;
//     } else {
//       filteredStations = stations
//           .where((station) => station.name.startsWith(selectedAlphabet))
//           .toList();
//     }
//     notifyListeners();
//   }
// }
//
//


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/config/app_config.dart';
import '../models/ipad16_model.dart';

class Ipad16Controller extends ChangeNotifier {

  Ipad16Controller() {
    fetchStations();
    selectedAlphabet = 'A';
  }

  List<Station> stations = [];
  List<Station> filteredStations = [];
  bool isLoading = false;
  String errorMessage = '';
  String selectedAlphabet = '';
  Station? selectedStation; // To store the selected station

  // Method to change color and store selected station
  void changeSelectedStation(Station station) {
    selectedStation = station; // Set the selected station
    notifyListeners();
  }

  void changeColor({required String selectedValue}) {
    selectedAlphabet = selectedValue;
    filterStations();
    notifyListeners();
  }

  // Function to fetch station data from the API
  Future<void> fetchStations() async {
    final String apiUrl = "https://api.g00r.com.au/API/getStations";

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
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "serverKey": AppConfig.serverKey,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          stations = (data['stations'] as List)
              .map((station) => Station.fromJson(station))
              .toList();
          filterStations();
          errorMessage = '';
        } else {
          errorMessage = data['message'] ?? 'Failed to fetch stations';
        }
      } else {
        errorMessage = 'Failed to fetch stations: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Method to filter stations based on the selected alphabet
  void filterStations() {
    if (selectedAlphabet.isEmpty) {
      filteredStations = stations;
    } else {
      filteredStations = stations
          .where((station) => station.name.startsWith(selectedAlphabet))
          .toList();
    }
    notifyListeners();
  }
}

