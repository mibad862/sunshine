class VehicleStatusModel {
  VehicleStatusModel({
    required this.vehicleDetailId,
    required this.name,
    required this.description,
    required this.firstName,
    required this.lastName,
    required this.value,
    required this.otherValue,
    required this.vehicleDetailCreatedAt,
  });

  final dynamic vehicleDetailId;
  final String? name;
  final String? description;
  final String? firstName;
  final String? lastName;
  final String? value;
  final String? otherValue;
  final String? vehicleDetailCreatedAt;

  factory VehicleStatusModel.fromJson(Map<String, dynamic> json) {
    return VehicleStatusModel(
      vehicleDetailId: json["vehicleDetailId"],
      name: json["name"],
      description: json["description"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      value: json["value"],
      otherValue: json["otherValue"],
      vehicleDetailCreatedAt: json["vehicleDetailCreatedAt"],
    );
  }

  Map<String, dynamic> toJson() => {
        "vehicleDetailId": vehicleDetailId,
        "name": name,
        "description": description,
        "firstName": firstName,
        "lastName": lastName,
        "value": value,
        "otherValue": otherValue,
        "vehicleDetailCreatedAt": vehicleDetailCreatedAt,
      };
}
