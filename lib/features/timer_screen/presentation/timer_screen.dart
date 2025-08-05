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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scheduleProvider = Provider.of<ScheduleProvider>(
        context,
        listen: false,
      );
      scheduleProvider.loadSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChosenStationDisplay(
              stationName: scheduleProvider.getStationName(scheduleProvider.selectedStationNumber),
            ),
            const SizedBox(height: 20),
            TimerDisplay(),
            const NextTrainTimeDisplay(),
            const SizedBox(height: 100),
            const ChooseDirectionButtons(),
          ],
        ),
      ),
    );
  }
}
