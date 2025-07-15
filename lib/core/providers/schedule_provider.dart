import 'package:flutter/foundation.dart';
import '../../data/models/schedule_model.dart';
import '../../data/repositories/schedule_repository.dart';

class ScheduleProvider with ChangeNotifier {
  final ScheduleRepository _repository;
  Map<String, StationSchedule> _schedules = {};
  String? _selectedStation;

  ScheduleProvider(this._repository);

  Map<String, StationSchedule> get schedules => _schedules;
  String? get selectedStation => _selectedStation;

  Future<void> loadSchedules() async {
    _schedules = await _repository.loadAllSchedules();
    notifyListeners();
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