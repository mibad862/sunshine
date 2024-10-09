class DriverStatusModel {
  DriverStatusModel({
    required this.clockStatus,
    required this.breakStatus,
    required this.vehicleAllocationStatus,
  });

  final String? clockStatus;
  final String? breakStatus;
  final String? vehicleAllocationStatus;

  factory DriverStatusModel.fromJson(Map<String, dynamic> json) {
    return DriverStatusModel(
      clockStatus: json["clockStatus"],
      breakStatus: json["breakStatus"],
      vehicleAllocationStatus: json["vehicleAllocationStatus"],
    );
  }

  Map<String, dynamic> toJson() => {
        "clockStatus": clockStatus,
        "breakStatus": breakStatus,
        "vehicleAllocationStatus": vehicleAllocationStatus,
      };
}
