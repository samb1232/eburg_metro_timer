// Модель для хранения расписания
class StationSchedule {
  final String stationName;
  final Map<String, List<String>> weekdays;
  final Map<String, List<String>> weekends;

  StationSchedule({
    required this.stationName,
    required this.weekdays,
    required this.weekends,
  });

// TODO: Добавить методы преобразования времени
}