import 'package:flutter/foundation.dart';
import '../../data/models/direction.dart';
import '../../data/models/station_schedule.dart';
import '../../data/repositories/schedule_repository.dart';


class ScheduleProvider with ChangeNotifier {
  final ScheduleRepository _repository;
  ScheduleProvider(this._repository);

  Map<int, StationSchedule> _schedules = {};
  Map<int, StationSchedule> get schedules => _schedules;

  int _selectedStationNumber = 1;
  int get selectedStationNumber => _selectedStationNumber;

  Direction _selectedDirection = Direction.toLast;
  Direction get selectedDirection => _selectedDirection;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Exception? _loadError;
  Exception? get loadError => _loadError;

  List<int> _stationOrder = [];
  List<int> get stationOrder => _stationOrder;

  Future<void> loadSchedules() async {
    if (_isLoading) return;

    _isLoading = true;
    _loadError = null;
    notifyListeners();

    try {
      final jsonData = await _repository.loadAllSchedules();
      _schedules = jsonData;
      _stationOrder = _schedules.keys.toList()..sort();
    } catch (e) {
      _loadError = e is Exception ? e : Exception('Failed to load schedules');
      _schedules = {};
      _stationOrder = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectStation(int stationNumber) {
    _selectedStationNumber = stationNumber;

    if (stationNumber == _stationOrder.first) {
      _selectedDirection = Direction.toLast;
    } else if (stationNumber == _stationOrder.last) {
      _selectedDirection = Direction.toFirst;
    }

    notifyListeners();
  }

  bool isDirectionAvailable(Direction direction) {
    if (_stationOrder.isEmpty) return false;

    if (_selectedStationNumber == _stationOrder.first) {
      return direction != Direction.toFirst;
    }
    if (_selectedStationNumber == _stationOrder.last) {
      return direction != Direction.toLast;
    }
    return true;
  }

  void selectDirection(Direction direction) {
    if (!isDirectionAvailable(direction)) return;

    _selectedDirection = direction;
    notifyListeners();
  }

  String getStationName(int stationNumber) {
    return _schedules[stationNumber]?.stationName ?? 'Unknown Station';
  }

  String getSelectedStationName() {
    return getStationName(_selectedStationNumber);
  }

  List<String>? getCurrentSchedule(bool isWeekend) {
    return _schedules[_selectedStationNumber]?.getSchedule(
      isWeekend,
      _selectedDirection == Direction.toFirst ? 'to_first' : 'to_last',
    );
  }
}
