class StationSchedule {
  final int stationNumber;
  final String stationName;
  final Map<String, Map<String, List<String>>> schedule;

  StationSchedule({
    required this.stationNumber,
    required this.stationName,
    required this.schedule,
  });

  factory StationSchedule.fromJson(int stationNumber, Map<String, dynamic> json) {
    return StationSchedule(
      stationName: json['name'] as String,
      stationNumber: stationNumber,
      schedule: {
        'weekday': _convertDirectionMap(json['schedule']['weekday']),
        'weekend': _convertDirectionMap(json['schedule']['weekend']),
      },
    );
  }

  static Map<String, List<String>> _convertDirectionMap(dynamic data) {
    if (data is! Map<String, dynamic>) return {};

    final Map<String, List<String>> result = {};
    data.forEach((key, value) {
      if (value is List<dynamic>) {
        result[key] = value.map((e) => e.toString()).toList();
      }
    });
    return result;
  }

  List<String>? getSchedule(bool isWeekend, String direction) {
    final dayType = isWeekend ? 'weekend' : 'weekday';
    return schedule[dayType]?[direction];
  }
}