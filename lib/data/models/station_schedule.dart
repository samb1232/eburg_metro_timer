class StationSchedule {
  final String stationName;
  final Map<String, List<String>> weekdays;
  final Map<String, List<String>> weekends;

  StationSchedule({
    required this.stationName,
    required this.weekdays,
    required this.weekends,
  });

  factory StationSchedule.fromJson(String name, Map<String, dynamic> json) {
    return StationSchedule(
      stationName: name,
      weekdays: Map<String, List<String>>.from(json['weekdays'] ?? {}),
      weekends: Map<String, List<String>>.from(json['weekends'] ?? {}),
    );
  }
}