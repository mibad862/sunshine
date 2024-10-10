import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/models/ipad14_model.dart';
import 'package:sunshine_app/pref/prefUtils.dart';

import 'package:sunshine_app/services/api_service.dart';

class VLineController extends ChangeNotifier {

 bool isLoading = false;
  VLineModel? vLineResponse;
  String _selectedNameId='';
 
  String? errorMessage; // For error handling
    // Getter for selectedName
  String get selectedNameId => _selectedNameId;
 


  // Function to get customers
  Future<void> getVlines() async {
    isLoading = true;
    errorMessage = null; // Reset error message
    notifyListeners(); // Notify listeners about the loading state

    try {
      final response = await apiService.callPostApi(
        apiPath: 'getVlineLines',
        apiData: {},
      );

      log('getVlineLines API called with response: $response');

      if (response == null) {
        throw Exception('Invalid API response');
      }

      // Parsing the API response
      if (response["status"] == "success") {
       vLineResponse  = VLineModel.fromJson(response);
        
     

        // Store customer IDs and names
        await _storeCustomerIdsAndNames();
      } else {
        errorMessage = "Failed to fetch customers.";
        log("Something went wrong!!! Response: $response");
      }
    } catch (e) {
      // If an error occurs, try to load data from Shared Preferences
      log('Error in getMetrolines API: $e. Trying to load from cache...');
      await _loadCachedData();
    }

    isLoading = false;
    notifyListeners(); // Notify listeners about the loading completion
  }

  // Private method to extract and store customer IDs and Names
  Future<void> _storeCustomerIdsAndNames() async {
    if (vLineResponse != null && vLineResponse!.customers.isNotEmpty) {
      List<String> VlineIds = [];
      List<String> VlineNames = [];

      for (var customer in vLineResponse!.customers) {
        VlineIds.add(customer.id);
        VlineNames.add(customer.name);
      }

     // Store the lists in Shared Preferences using nb_utils
      await setValue(PrefKeys.vLineIds, VlineIds);
      await setValue(PrefKeys.vLineNames, VlineNames);

      log('Customer IDs and Names stored in Shared Preferences.');
    }
  }

  // **New Method:** Set Selected Customer Name
  Future<void> setSelectedNameId(String name) async {
    _selectedNameId = name;
    //log('Selected Customer Name: $selectedName');
    notifyListeners();
  }
  
  
  Future<void> _loadCachedData() async {
    List<String> vLineIds = getStringListAsync(PrefKeys.vLineIds) ?? [];
    List<String> vLineNames = getStringListAsync(PrefKeys.vLineNames) ?? [];

  if (vLineIds.isNotEmpty && vLineNames.isNotEmpty) {
    vLineResponse = VLineModel(
      status: 'success', // Provide a default or cached status value
      message: 'Loaded from cache', // Provide a default or cached message value
      customers: List.generate(vLineIds.length, (index) {
        return Customer(id: vLineIds[index], name: vLineNames[index],operatorId: '',createdAt: '',updatedAt: '',status: '');
      }),
    );
    log('Loaded metro lines from cache.');
  } else {
    errorMessage = "No cached data available.";
  }
  }

}

