import '../datasources/local_data_source.dart';
import '../models/station_schedule.dart';

class ScheduleRepository {
  final LocalDataSource _localDataSource;

  ScheduleRepository(this._localDataSource);

  Future<Map<int, StationSchedule>> loadAllSchedules() async {
    final jsonData = await _localDataSource.loadJsonData();
    final stations = jsonData['stations'] as Map<String, dynamic>;
    final stationOrder = List<int>.from(jsonData['station_order'] as List);

    return Map.fromEntries(
      stationOrder.map((stationNumber) {
        final stationData = stations[stationNumber.toString()] as Map<String, dynamic>;
        return MapEntry(
          stationNumber,
          StationSchedule.fromJson(stationNumber, stationData),
        );
      }),
    );
  }

  Future<List<String>> getStationNames() async {
    final jsonData = await _localDataSource.loadJsonData();
    final stations = jsonData['stations'] as Map<String, dynamic>;
    return stations.values
        .map((station) => station['name'] as String)
        .toList();
  }

  Future<StationSchedule?> getSchedule(int stationNumber) async {
    final jsonData = await _localDataSource.loadJsonData();
    final stations = jsonData['stations'] as Map<String, dynamic>;
    if (stations.containsKey(stationNumber.toString())) {
      return StationSchedule.fromJson(
        stationNumber,
        stations[stationNumber.toString()] as Map<String, dynamic>,
      );
    }
    return null;
  }
}