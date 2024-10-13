class Station {
  String id;
  String name;
  String? stationOrder; // Allow nullable values
  String? lineId;
  String? lineName;

  Station({
    required this.id,
    required this.name,
    this.stationOrder,
    this.lineId,
    this.lineName,
  });

  // Factory method to create a Station from JSON
  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'],
      name: json['name'],
      stationOrder: json['station_order'],
      lineId: json['line_id'],
      lineName: json['line_name'],
    );
  }
}
