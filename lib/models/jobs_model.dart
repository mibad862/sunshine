class JobsModel {
  JobsModel({
    required this.id,
    required this.name,
    required this.time,
  });

  final int? id;
  final String? name;
  final DateTime? time;

  factory JobsModel.fromJson(Map<String, dynamic> json) {
    return JobsModel(
      id: json["id"],
      name: json["name"],
      time: DateTime.tryParse(json["time"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time": time?.toIso8601String(),
      };
}
