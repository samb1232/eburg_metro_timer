import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataSaver {
  static const String _fileName = 'user_preferences.json';

  static Future<void> saveData({
    required int stationId,
    required bool directionIsToLast,
  }) async {
    final data = {
      'station_id': stationId,
      'direction_is_to_last': directionIsToLast,
    };

    final file = await _getLocalFile();
    await file.writeAsString(jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> loadData() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        return jsonDecode(contents);
      } else {
        final data = {'station_id': 1, 'direction_is_to_last': true};

        final file = await _getLocalFile();
        await file.writeAsString(jsonEncode(data));
      }
    } catch (e) {
      print('Ошибка при загрузке данных: $e');
    }
    return null;
  }

  static Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }
}
