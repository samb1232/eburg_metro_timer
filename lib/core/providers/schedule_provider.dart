import 'package:flutter/foundation.dart';
import 'package:metro_schedule/data/models/direction.dart';
import '../../data/models/station_schedule.dart';
import '../../data/repositories/schedule_repository.dart';


class ScheduleProvider with ChangeNotifier {
  static const String firstStationName = "Проспект космонавтов";
  static const String lastStationName = "Ботаническая";

  final ScheduleRepository _repository;
  ScheduleProvider(this._repository);

  Map<String, StationSchedule> _schedules = {};
  Map<String, StationSchedule> get schedules => _schedules;

  String _selectedStation = firstStationName;
  String get selectedStation => _selectedStation;

  Direction _selectedDirection = Direction.toLast;
  Direction get selectedDirection => _selectedDirection;

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
      _selectedDirection = Direction.toLast;
    } else if (stationName == lastStationName) {
      _selectedDirection = Direction.toFirst;
    }

    notifyListeners();
  }

  bool isDirectionAvailable(Direction direction) {
    if (_selectedStation == firstStationName) return direction != Direction.toFirst;
    if (_selectedStation == lastStationName) return direction != Direction.toLast;
    return true;
  }

  void selectDirection(Direction direction) {
    if (!isDirectionAvailable(direction)) return;

    _selectedDirection = direction;
    notifyListeners();
  }
}
