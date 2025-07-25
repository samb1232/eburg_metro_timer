import 'package:flutter/material.dart';
import 'package:metro_schedule/features/timer_screen/presentation/widgets/choose_direction_buttons.dart';
import 'widgets/chosen_station_display.dart';
import 'widgets/next_train_time_display.dart';
import 'widgets/timer_display.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ChosenStationDisplay(),
            const TimerDisplay(),
            const NextTrainTimeDisplay(),
            const ChooseDirectionButtons(),
          ],
        ),
      ),
    );
  }
}
