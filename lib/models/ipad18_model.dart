class Ipad18Model {
  final String emergencyCallOutId;
  final String startingStation;
  final String destinationStation;
  final String lineName;
  final String nextStation;
  final String nextStationId;
  final String reason;
  final String stoppingPattern;
  final String paxCount;

  Ipad18Model({
    required this.emergencyCallOutId,
    required this.startingStation,
    required this.destinationStation,
    required this.lineName,
    required this.nextStation,
    required this.nextStationId,
    required this.reason,
    required this.stoppingPattern,
    required this.paxCount,
  });

  factory Ipad18Model.fromJson(Map<String, dynamic> json) {
    return Ipad18Model(
      emergencyCallOutId: json['emergencyCallOutId'],
      startingStation: json['startingStation'],
      destinationStation: json['destinationStation'],
      lineName: json['lineName'],
      nextStation: json['nextStation'],
      nextStationId: json['nextStationId'],
      reason: json['reason'],
      stoppingPattern: json['stoppingPattern'],
      paxCount: json['paxCount'],
    );
  }
}
