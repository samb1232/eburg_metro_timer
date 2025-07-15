import 'package:flutter/material.dart';
import '../features/timer/presentation/timer_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/timer':
        return MaterialPageRoute(builder: (_) => const TimerScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
          body: Center(child: Text('Нет рута для ${settings.name}')),
        )
        );
    }
  }
}