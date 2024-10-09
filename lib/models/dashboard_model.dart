class DashboardModel {
  DashboardModel({
    required this.drivers,
    required this.vehicleFaults,
    required this.vehicleStatus,
  });

  final List<Driver> drivers;
  final List<VehicleFault> vehicleFaults;
  final List<VehicleStatus> vehicleStatus;

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      drivers: json["drivers"] == null
          ? []
          : List<Driver>.from(json["drivers"]!.map((x) => Driver.fromJson(x))),
      vehicleFaults: json["vehicleFaults"] == null
          ? []
          : List<VehicleFault>.from(
              json["vehicleFaults"]!.map((x) => VehicleFault.fromJson(x))),
      vehicleStatus: json["vehicleStatus"] == null
          ? []
          : List<VehicleStatus>.from(
              json["vehicleStatus"]!.map((x) => VehicleStatus.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "drivers": drivers.map((x) => x.toJson()).toList(),
        "vehicleFaults": vehicleFaults.map((x) => x.toJson()).toList(),
        "vehicleStatus": vehicleStatus.map((x) => x.toJson()).toList(),
      };
}

class Driver {
  Driver({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.clockinStatus,
    required this.statusMessage,
    required this.color,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? clockinStatus;
  final String? statusMessage;
  final String? color;

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      clockinStatus: json["clockin_status"],
      statusMessage: json["statusMessage"],
      color: json["color"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "clockin_status": clockinStatus,
        "statusMessage": statusMessage,
        "color": color,
      };
}

class VehicleFault {
  VehicleFault({
    required this.id,
    required this.vehicle,
    required this.driver,
    required this.safeToDrive,
    required this.status,
    required this.faultType,
    required this.fault,
    required this.driverDefineFault,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? vehicle;
  final int? driver;
  final String? safeToDrive;
  final String? status;
  final String? faultType;
  final String? fault;
  final String? driverDefineFault;
  final dynamic location;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory VehicleFault.fromJson(Map<String, dynamic> json) {
    return VehicleFault(
      id: json["id"],
      vehicle: json["vehicle"],
      driver: json["driver"],
      safeToDrive: json["safeToDrive"],
      status: json["status"],
      faultType: json["faultType"],
      fault: json["fault"],
      driverDefineFault: json["driverDefineFault"],
      location: json["location"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle": vehicle,
        "driver": driver,
        "safeToDrive": safeToDrive,
        "status": status,
        "faultType": faultType,
        "fault": fault,
        "driverDefineFault": driverDefineFault,
        "location": location,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class VehicleStatus {
  VehicleStatus({
    required this.name,
    required this.value,
  });

  final String? name;
  final String? value;

  factory VehicleStatus.fromJson(Map<String, dynamic> json) {
    return VehicleStatus(
      name: json["name"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
