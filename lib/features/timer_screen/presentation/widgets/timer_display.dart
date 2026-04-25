import 'dart:async';
import 'package:flutter/material.dart';
import 'package:metro_schedule/core/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

class TimerDisplay extends StatefulWidget {
  const TimerDisplay({super.key});

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  Duration _timeRemaining = Duration.zero;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 300), (_) => _updateTime());
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final provider = Provider.of<ScheduleProvider>(context, listen: false);
    if (provider.stationOrder.isEmpty || provider.schedules.isEmpty) {
      return;
    }

    final now = DateTime.now();
    final isWeekend = now.weekday >= DateTime.saturday;
    final station = provider.schedules[provider.selectedStationNumber];
    if (station == null) return;

    final direction = provider.selectedDirection.value;
    final schedule = station.getSchedule(isWeekend, direction) ?? [];

    // Находим ближайшее время
    String? nextTime;
    for (final timeStr in schedule) {
      final timeParts = timeStr.split(':');
      if (timeParts.length != 2) continue;

      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = int.tryParse(timeParts[1]) ?? 0;
      final trainTime = DateTime(now.year, now.month, now.day, hour, minute);

      if (trainTime.isAfter(now)) {
        nextTime = timeStr;
        break;
      }
    }

    if (nextTime == null && schedule.isNotEmpty) {
      nextTime = schedule.first;
    }

    if (nextTime != null) {
      final timeParts = nextTime.split(':');
      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = int.tryParse(timeParts[1]) ?? 0;
      var trainTime = DateTime(now.year, now.month, now.day, hour, minute);

      if (trainTime.isBefore(now)) {
        trainTime = trainTime.add(const Duration(days: 1));
      }

      setState(() {
        _timeRemaining = trainTime.difference(now);
      });
    }
  }

  Widget _buildFormattedTimer(Duration duration, ColorScheme colorScheme) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (minutes == 0) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$seconds',
              style: TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            TextSpan(
              text: 'сек',
              style: TextStyle(
                fontSize: 24,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }
    else {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$minutes',
              style: TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            TextSpan(
              text: 'мин',
              style: TextStyle(
                fontSize: 24,
                color: colorScheme.onSurface,
              ),
            ),
            TextSpan(
              text: '$seconds',
              style: TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            TextSpan(
              text: 'сек',
              style: TextStyle(
                fontSize: 24,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFormattedTimer(_timeRemaining, colorScheme),
      ],
    );
  }
}
