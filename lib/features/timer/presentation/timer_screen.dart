import 'package:flutter/material.dart';
import 'widgets/timer_display.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Таймер метро')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TODO: Получить текущую станцию из состояния
          Text('Проспект Космонавтов → Ботаническая', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 40),
          const TimerDisplay(), // Основной виджет таймера
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.train),
                onPressed: () => Navigator.pushNamed(context, '/station'),
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Navigator.pushNamed(context, '/settings'),
              ),
            ],
          )
        ],
      ),
    );
  }
}