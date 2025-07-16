import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '02:15',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 64),
        ),
      ],
    );
  }
}