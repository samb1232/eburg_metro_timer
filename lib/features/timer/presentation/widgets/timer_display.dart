import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Заменить заглушку реальными данными
    return Column(
      children: [
        Text('До прибытия', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 20),
        Text(
          '02:15',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 64),
        ),
        const SizedBox(height: 20),
        Text('Следующий поезд через 5 мин', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}