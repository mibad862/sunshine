import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/models/customerResponse_model.dart';
import 'package:sunshine_app/pref/prefUtils.dart';

import 'package:sunshine_app/services/api_service.dart';

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

  // Function to get customers
  // Function to get customers
  Future<void> getCustomers() async {
    isLoading = true;
    errorMessage = null; // Reset error message
    notifyListeners(); // Notify listeners about the loading state

    try {
      final response = await apiService.callPostApi(
        apiPath: 'getCustomers',
        apiData: {},
      );

      log('getCustomers API called with response: $response');

      if (response == null) {
        throw Exception('Invalid API response');
      }

      // Parsing the API response
      if (response["status"] == "success") {
        customerResponse = CustomerResponse.fromJson(response);

        // Store customer IDs and names
        await _storeCustomerIdsAndNames();
      } else {
        errorMessage = "Failed to fetch customers.";
        log("Something went wrong!!! Response: $response");
      }
    } catch (e) {
      errorMessage = "An error occurred: $e";
      log('Error in getCustomers API: $e');
      await _loadCachedCustomerNames();
    }
    isLoading = false;

    notifyListeners(); // Notify listeners about the loading completion if context is still mounted
  }

  // Private method to extract and store customer IDs and Names
  Future<void> _storeCustomerIdsAndNames() async {
    if (customerResponse != null && customerResponse!.customers.isNotEmpty) {
      List<String> customerIds = [];
      List<String> customerNames = [];

      for (var customer in customerResponse!.customers) {
        customerIds.add(customer.id);
        customerNames.add(customer.name);
      }

      // Store the lists in Shared Preferences using nb_utils
      await setValue(PrefKeys.customerIds, customerIds);
      await setValue(PrefKeys.customerNames, customerNames);

      log('Customer IDs and Names stored in Shared Preferences.');
    }
  }

  // **New Method:** Set Selected Customer Name
  Future<void> setSelectedNameId(String name) async {
    _selectedNameId = name;
    //log('Selected Customer Name: $selectedName');
    notifyListeners();
  }

  // Set the selected time
  void setSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

// Method to load cached customer names from Shared Preferences
  Future<void> _loadCachedCustomerNames() async {
    List<String> cachedCustomerIds =
        getStringListAsync(PrefKeys.customerIds) ?? [];
    List<String> cachedCustomerNames =
        getStringListAsync(PrefKeys.customerNames) ?? [];

    if (cachedCustomerIds.isNotEmpty && cachedCustomerNames.isNotEmpty) {
      List<Customer> cachedCustomers =
          List.generate(cachedCustomerIds.length, (index) {
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

      log('Loaded customer names from cache.');
      notifyListeners(); // Notify listeners about the data change
    } else {
      log('No cached customer data available.');
      errorMessage = "No cached data available.";
    }
  }
}
