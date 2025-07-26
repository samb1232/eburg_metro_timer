import 'package:flutter/foundation.dart';
import '../../data/models/station_schedule.dart';
import '../../data/repositories/schedule_repository.dart';

class ScheduleProvider with ChangeNotifier {
  final ScheduleRepository _repository;
  ScheduleProvider(this._repository);

  Map<String, StationSchedule> _schedules = {};
  Map<String, StationSchedule> get schedules => _schedules;

  String _selectedStation = "Ботаническая";
  String get selectedStation => _selectedStation;

  String _selectedDirection = "to_first";
  String get selectedDirection => _selectedDirection;

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
    notifyListeners();
  }

  void selectDirection(String direction) {
    _selectedDirection = direction;
    notifyListeners();
  }
}