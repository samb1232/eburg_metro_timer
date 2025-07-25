import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // @todo #3: add real countdown timer instead of text placeholder
        // @todo #9: display timer in style "2min15sec"
        Text(
          '02:15',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 64),
        ),
      ],
    );
  }
}