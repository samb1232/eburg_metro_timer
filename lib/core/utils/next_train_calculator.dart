import 'package:flutter/material.dart';

import '../providers/schedule_provider.dart';

class NextTrainCalculator {
  static String? calculateNextTrainTime({
    required ScheduleProvider scheduleProvider,
    required TimeOfDay currentTime,
    required bool isWeekend,
  }) {
    if (scheduleProvider.schedules.isEmpty) return null;

    final currentStation = scheduleProvider.selectedStation;
    final currentDirection = scheduleProvider.selectedDirection;

    final stationSchedule = scheduleProvider.schedules[currentStation];
    if (stationSchedule == null) return null;

    final schedule = isWeekend ? stationSchedule.weekends : stationSchedule.weekdays;
    final directionKey = currentDirection.value;
    final trainTimes = schedule[directionKey] ?? [];

    String? nextTrainTime;
    for (final timeStr in trainTimes) {
      final timeParts = timeStr.split(':');
      if (timeParts.length != 2) continue;

      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = int.tryParse(timeParts[1]) ?? 0;
      final trainTime = TimeOfDay(hour: hour, minute: minute);

      if (trainTime.hour > currentTime.hour ||
          (trainTime.hour == currentTime.hour && trainTime.minute >= currentTime.minute)) {
        nextTrainTime = timeStr;
        break;
      }
    }

    // If no train found today, take first train of the next day
    if (nextTrainTime == null && trainTimes.isNotEmpty) {
      nextTrainTime = trainTimes.first;
    }

    return nextTrainTime;
  }
}