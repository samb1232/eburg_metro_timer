import 'package:flutter/foundation.dart';
import '../../data/models/station_schedule.dart';
import '../../data/repositories/schedule_repository.dart';

class ScheduleProvider with ChangeNotifier {
  final ScheduleRepository _repository;
  Map<String, StationSchedule> _schedules = {};
  String? _selectedStation;

  ScheduleProvider(this._repository);

  Map<String, StationSchedule> get schedules => _schedules;
  String? get selectedStation => _selectedStation;

  bool _isLoading = false;
  Exception? _loadError;

  bool get isLoading => _isLoading;
  Exception? get loadError => _loadError;

  Future<void> loadSchedules() async {
    if (_isLoading) return; // Prevent multiple loads

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

  Future<StationSchedule?> getSelectedSchedule() async {
    if (_selectedStation == null) return null;
    return await _repository.getSchedule(_selectedStation!);
  }
}