import 'package:flutter/material.dart';
import 'package:metro_schedule/core/utils/next_train_calculator.dart';
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
        _updateNextTrainTime(scheduleProvider);
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    _updateNextTrainTime(scheduleProvider);
  }

  void _updateNextTrainTime(ScheduleProvider scheduleProvider) {
    final nextTime = NextTrainCalculator.calculateNextTrainTime(
      scheduleProvider: scheduleProvider,
      currentTime: TimeOfDay.now(),
      isWeekend: DateTime.now().weekday >= DateTime.saturday,
    );

    if (nextTime != _nextTrainTime) {
      setState(() {
        _nextTrainTime = nextTime;
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
