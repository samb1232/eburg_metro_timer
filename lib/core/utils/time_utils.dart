import 'package:flutter/cupertino.dart';

class TimeUtils {
  static List<String> getNextTrainTimes({
    required Map<String, List<String>> schedule,
    required String direction,
    required DateTime currentTime,
    int count = 3,
  }) {
    final times = schedule[direction] ?? [];
    final currentTimeStr = _formatTime(currentTime);

    final nextTrains = times.where((time) => time.compareTo(currentTimeStr) >= 0);

    return nextTrains.take(count).toList();
  }

  static String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String formatTimeLeft(DateTime now, String trainTime) {
    final trainDateTime = DateTime(now.year, now.month, now.day,
        int.parse(trainTime.split(':')[0]), int.parse(trainTime.split(':')[1]));

    final difference = trainDateTime.difference(now);

    if (difference.isNegative) {
      return '00:00';
    }

    return '${difference.inMinutes.toString().padLeft(2, '0')}:${(difference.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  static String calculateTimeLeft(DateTime now, String trainTime) {
    try {
      final trainMinutes = _parseAndConvertTimeToMinutes(trainTime);
      final nowMinutes = _convertDateTimeToMinutes(now);
      final diffMinutes = _calculateTimeDifference(nowMinutes, trainMinutes);

      return _formatTimeDifference(diffMinutes, now.second);
    } catch (e) {
      debugPrint('Error calculating time left: $e');
      return '--:--';
    }
  }
  static int _parseAndConvertTimeToMinutes(String time) {
    final timeParts = time.split(':');
    if (timeParts.length != 2) {
      throw FormatException('Invalid time format');
    }

    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    return hour * 60 + minute;
  }

  static int _convertDateTimeToMinutes(DateTime dateTime) {
    return dateTime.hour * 60 + dateTime.minute;
  }


  static int _calculateTimeDifference(int nowMinutes, int trainMinutes) {
    int diffMinutes = trainMinutes - nowMinutes;
    if (diffMinutes < 0) {
      diffMinutes += 24 * 60; // In the case of midnight
    }
    return diffMinutes;
  }

  static String _formatTimeDifference(int diffMinutes, int currentSeconds) {
    final minutes = diffMinutes % 60;
    final hours = diffMinutes ~/ 60;
    if (hours > 0) {
      return '${_twoDigits(hours)}:${_twoDigits(minutes)}';
    }
    return '${_twoDigits(minutes)}:${_twoDigits(60 - currentSeconds)}';
  }

  static String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  static bool isWeekend(DateTime date) {
    final weekday = date.weekday;
    return weekday == DateTime.saturday || weekday == DateTime.sunday;
  }
}