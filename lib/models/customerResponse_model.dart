class CustomerResponse {
  final String status;
  final String message;
  final List<Customer> customers;

  CustomerResponse({
    required this.status,
    required this.message,
    required this.customers,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    return CustomerResponse(
      status: json['status'],
      message: json['message'],
      customers: (json['customers'] as List<dynamic>)
          .map((customer) => Customer.fromJson(customer))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'customers': customers.map((customer) => customer.toJson()).toList(),
    };
  }
}

class Customer {
  final String id;
  final String name;
  final String status;
  final String createdAt;
  final String updatedAt;

  Customer({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
