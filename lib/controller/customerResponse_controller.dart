import 'dart:convert'; // Needed for json encoding and decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:nb_utils/nb_utils.dart'; // For shared preferences or toast
import 'package:sunshine_app/models/customerResponse_model.dart';
import 'package:sunshine_app/pref/prefUtils.dart';

class CustomerController extends ChangeNotifier {
  bool isLoading = false;
  CustomerResponse? customerResponse;
  String _selectedNameId = '';
  String _selectedTime = '';
  String? errorMessage; // For error handling

  // Getter for selectedName
  String get selectedNameId => _selectedNameId;

  // Getter for selectedTime
  String get selectedTime => _selectedTime;
  final String serverKey = "3d41895d9c88b284a88103da2ab45cc5";
  final String authToken = getStringAsync('auth_token');

  // Function to get customers
  Future<void> getCustomers() async {
    if (authToken == null || authToken.isEmpty) {
      errorMessage = "Authentication token is missing.";
      toast(errorMessage);
      return;
    }

    isLoading = true;
    errorMessage = null; // Reset error message
    notifyListeners(); // Notify listeners about the loading state

    log(authToken);

    // API endpoint URL
    String url = 'https://api.g00r.com.au/API/getCustomers';

    // Request headers
    Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    // Request body
    Map<String, dynamic> body = {
      'serverKey': serverKey,
    };

    try {
      // Make HTTP POST request
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body), // Encode the body to JSON format
      );

      // Parse the response
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        log('Response: $responseData');

        if (responseData["status"] == "success") {
          toast(responseData['message']);
          customerResponse = CustomerResponse.fromJson(responseData);
          await _storeCustomerIdsAndNames();
        } else {
          log(responseData['message']);
          toast(responseData['message']);
          errorMessage = "Failed to fetch customers.";
        }
      } else if (response.statusCode == 401) {
        errorMessage = "Unauthorized request. Please check your token.";
        toast(errorMessage);
      } else if (response.statusCode == 500) {
        errorMessage = "Server error. Please try again later.";
        toast(errorMessage);
      } else {
        errorMessage = "Unexpected error occurred. Status code: ${response.statusCode}";
        toast(errorMessage);
      }
    } catch (e) {
      log('Error: $e');
      toast("An error occurred: $e");
      errorMessage = "An error occurred: $e";
      await _loadCachedCustomerNames();
    }

    isLoading = false;
    notifyListeners(); // Notify listeners about the loading completion
  }

  // Method to store customer IDs and Names
  Future<void> _storeCustomerIdsAndNames() async {
    if (customerResponse != null && customerResponse!.customers.isNotEmpty) {
      List<String> customerIds = [];
      List<String> customerNames = [];

      for (var customer in customerResponse!.customers) {
        customerIds.add(customer.id);
        customerNames.add(customer.name);
      }

      await setValue(PrefKeys.customerIds, customerIds);
      await setValue(PrefKeys.customerNames, customerNames);
    }
  }

  // Set Selected Customer Name
  Future<void> setSelectedNameId(String name) async {
    _selectedNameId = name;

    await setValue('customerId', _selectedNameId);
    notifyListeners();
  }

  // Set selected time
  void setSelectedTime(String time) async{
    _selectedTime = time;
    await setValue('callOutTime', _selectedTime);
    notifyListeners();
  }

  // Load cached customer names from Shared Preferences
  Future<void> _loadCachedCustomerNames() async {
    List<String> cachedCustomerIds = getStringListAsync(PrefKeys.customerIds) ?? [];
    List<String> cachedCustomerNames = getStringListAsync(PrefKeys.customerNames) ?? [];

    if (cachedCustomerIds.isNotEmpty && cachedCustomerNames.isNotEmpty) {
      List<Customer> cachedCustomers = List.generate(cachedCustomerIds.length, (index) {
        return Customer(
          id: cachedCustomerIds[index],
          name: cachedCustomerNames[index],
          status: 'cached',
          createdAt: '',
          updatedAt: '',
        );
      });

      customerResponse = CustomerResponse(
        status: 'cached',
        message: 'Loaded from cache due to network error',
        customers: cachedCustomers,
      );

      notifyListeners();
    } else {
      errorMessage = "No cached data available.";
    }
  }
}
