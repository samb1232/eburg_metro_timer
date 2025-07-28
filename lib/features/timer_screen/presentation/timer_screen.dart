import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/schedule_provider.dart';
import 'widgets/choose_direction_buttons.dart';
import 'widgets/chosen_station_display.dart';
import 'widgets/next_train_time_display.dart';
import 'widgets/timer_display.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  String? _nextTrainTime;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scheduleProvider = Provider.of<ScheduleProvider>(
        context,
        listen: false,
      );
      scheduleProvider.loadSchedules().then((_) {
        _calculateNextTrainTime(scheduleProvider);
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    _calculateNextTrainTime(scheduleProvider);
  }

  void _calculateNextTrainTime(ScheduleProvider scheduleProvider) {
    if (scheduleProvider.schedules.isEmpty) return;

    final now = TimeOfDay.now();
    final currentStation = scheduleProvider.selectedStation;
    final currentDirection = scheduleProvider.selectedDirection;
    final isWeekend = DateTime.now().weekday >= DateTime.saturday;

    final stationSchedule = scheduleProvider.schedules[currentStation];
    if (stationSchedule == null) return;

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

      if (trainTime.hour > now.hour ||
          (trainTime.hour == now.hour && trainTime.minute >= now.minute)) {
        nextTrainTime = timeStr;
        break;
      }
    }
    // If no train found today, take first train of the next day
    if (nextTrainTime == null && trainTimes.isNotEmpty) {
      nextTrainTime = trainTimes.first;
    }

    if (nextTrainTime != _nextTrainTime) {
      setState(() {
        _nextTrainTime = nextTrainTime;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChosenStationDisplay(scheduleProvider.selectedStation),
            const SizedBox(height: 20),
            TimerDisplay(nextTrainTime: _nextTrainTime),
            const NextTrainTimeDisplay(),
            const SizedBox(height: 100),
            const ChooseDirectionButtons(),
          ],
        ),
      ),
    );
  }
}
