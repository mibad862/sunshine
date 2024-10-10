import 'dart:convert';

// Main model for the entire response
class MetroLineModel {
  final String status;
  final String message;
  final List<Customer> customers;

  MetroLineModel({
    required this.status,
    required this.message,
    required this.customers,
  });

  // Factory method to create an instance from JSON
  factory MetroLineModel.fromJson(Map<String, dynamic> json) {
    return MetroLineModel(
      status: json['status'],
      message: json['message'],
      customers: (json['customers'] as List)
          .map((customer) => Customer.fromJson(customer))
          .toList(),
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'customers': customers.map((customer) => customer.toJson()).toList(),
    };
  }
}

// Model class for each customer
class Customer {
  final String id;
  final String name;
  final String operatorId; // Renamed to avoid conflict with the keyword "operator"
  final String status;
  final String createdAt;
  final String updatedAt;

  Customer({
    required this.id,
    required this.name,
    required this.operatorId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      operatorId: json['operator'], // Changed to operatorId
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'operator': operatorId, // Changed to operatorId
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
