import '../datasources/local_data_source.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  final LocalDataSource _localDataSource;

  ScheduleRepository(this._localDataSource);

  Future<Map<String, StationSchedule>> loadAllSchedules() async {
    final jsonData = await _localDataSource.loadJsonData();
    return jsonData.map((stationName, data) => MapEntry(
      stationName,
      StationSchedule.fromJson(stationName, data),
    ));
  }

  Future<List<String>> getStationNames() async {
    final jsonData = await _localDataSource.loadJsonData();
    return jsonData.keys.toList();
  }

  Future<StationSchedule?> getSchedule(String stationName) async {
    final jsonData = await _localDataSource.loadJsonData();
    if (jsonData.containsKey(stationName)) {
      return StationSchedule.fromJson(stationName, jsonData[stationName]);
    }
    return null;
  }
}