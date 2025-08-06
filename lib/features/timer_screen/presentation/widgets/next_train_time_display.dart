import 'package:flutter/material.dart';
import 'package:metro_schedule/core/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

class NextTrainTimeDisplay extends StatelessWidget {
  const NextTrainTimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    final isWeekend = DateTime.now().weekday == DateTime.saturday ||
        DateTime.now().weekday == DateTime.sunday;

    final schedule = scheduleProvider.getCurrentSchedule(isWeekend);

    if (schedule == null || schedule.isEmpty) {
      return const Text(
        'Нет данных о расписании',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }

    // Получаем текущее время
    final now = TimeOfDay.now();
    final currentMinutes = now.hour * 60 + now.minute;

    // Находим ближайшие три поезда
    final upcomingTrains = schedule
        .map((timeStr) {
      final parts = timeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return hour * 60 + minute;
    })
        .where((timeInMinutes) => timeInMinutes >= currentMinutes)
        .take(3)
        .map((timeInMinutes) {
      final hour = (timeInMinutes ~/ 60).toString().padLeft(2, '0');
      final minute = (timeInMinutes % 60).toString().padLeft(2, '0');
      return '$hour:$minute';
    })
        .toList();

    if (upcomingTrains.isEmpty) {
      return const Text(
        'Поездов сегодня больше нет',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }

    // Если ближайших поездов меньше 3, добавляем оставшиеся с начала следующего дня
    if (upcomingTrains.length < 3) {
      final remaining = 3 - upcomingTrains.length;
      final nextDayTrains = schedule
          .map((timeStr) {
        final parts = timeStr.split(':');
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return hour * 60 + minute;
      })
          .take(remaining)
          .map((timeInMinutes) {
        final hour = (timeInMinutes ~/ 60).toString().padLeft(2, '0');
        final minute = (timeInMinutes % 60).toString().padLeft(2, '0');
        return '$hour:$minute';
      })
          .toList();

      upcomingTrains.addAll(nextDayTrains);
    }

    return Text(
      'Следующий поезд: ${upcomingTrains.join(', ')}',
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}