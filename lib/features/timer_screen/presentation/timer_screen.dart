import 'package:flutter/material.dart';
import 'widgets/chosen_station_display.dart';
import 'widgets/nav_buttons_display.dart';
import 'widgets/next_train_time_display.dart';
import 'widgets/timer_display.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ChosenStationDisplay(),
          Column(
            children: [
              const TimerDisplay(),
              const NextTrainTimeDisplay(),
            ],
          ),
          const NavButtonsDisplay(),
        ],
      ),
    );
  }
}
