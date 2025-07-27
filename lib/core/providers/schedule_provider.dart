import 'package:flutter/foundation.dart';
import '../../data/models/station_schedule.dart';
import '../../data/repositories/schedule_repository.dart';

enum TrainDirection {
  toFirst('to_first'),
  toLast('to_last');

  final String value;

  const TrainDirection(this.value);
}

class ScheduleProvider with ChangeNotifier {
  static const String firstStationName = "Проспект космонавтов";
  static const String lastStationName = "Ботаническая";

  final ScheduleRepository _repository;
  ScheduleProvider(this._repository);

  Map<String, StationSchedule> _schedules = {};
  Map<String, StationSchedule> get schedules => _schedules;

  String _selectedStation = firstStationName;
  String get selectedStation => _selectedStation;

  TrainDirection _selectedDirection = TrainDirection.toLast;
  TrainDirection get selectedDirection => _selectedDirection;

  bool _isLoading = false;
  bool get isLoading => _isLoading;



  Exception? _loadError;
  Exception? get loadError => _loadError;

  Future<void> loadSchedules() async {
    if (_isLoading) return;

    _isLoading = true;
    _loadError = null;
    notifyListeners();

    try {
      _schedules = await _repository.loadAllSchedules();
    } catch (e) {
      _loadError = e is Exception ? e : Exception('Failed to load schedules');
      _schedules = {};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectStation(String stationName) {
    _selectedStation = stationName;

    if (stationName == firstStationName) {
      _selectedDirection = TrainDirection.toLast;
    } else if (stationName == lastStationName) {
      _selectedDirection = TrainDirection.toFirst;
    }

    notifyListeners();
  }

  bool isDirectionAvailable(TrainDirection direction) {
    if (_selectedStation == firstStationName) return direction != TrainDirection.toFirst;
    if (_selectedStation == lastStationName) return direction != TrainDirection.toLast;
    return true;
  }

  void selectDirection(TrainDirection direction) {
    if (!isDirectionAvailable(direction)) return;

    _selectedDirection = direction;
    notifyListeners();
  }
}
