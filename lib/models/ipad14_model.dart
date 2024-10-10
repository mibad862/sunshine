class VLineModel {
  final String status;
  final String message;
  final List<Customer> customers;

  VLineModel({
    required this.status,
    required this.message,
    required this.customers,
  });

  factory VLineModel.fromJson(Map<String, dynamic> json) {
    var customerList = json['customers'] as List;
    List<Customer> customerItems =
        customerList.map((customer) => Customer.fromJson(customer)).toList();

    return VLineModel(
      status: json['status'],
      message: json['message'],
      customers: customerItems,
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
  final String operatorId; // renamed to avoid using 'operator' keyword
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

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      operatorId: json['operator'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'operator': operatorId,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
