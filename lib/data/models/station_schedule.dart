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
      weekdays: _convertScheduleMap(json['weekdays']),
      weekends: _convertScheduleMap(json['weekends']),
    );
  }

  static Map<String, List<String>> _convertScheduleMap(dynamic data) {
    if (data is! Map<String, dynamic>) return {};

    final Map<String, List<String>> result = {};
    data.forEach((key, value) {
      if (value is List<dynamic>) {
        result[key] = value.map((e) => e.toString()).toList();
      }
    });
    return result;
  }
}