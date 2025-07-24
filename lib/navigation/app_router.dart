import 'package:flutter/material.dart';
import '../features/choose_station_screen/presentation/choose_station_screen.dart';
import '../features/timer_screen/presentation/timer_screen.dart';

class AppRouter {
  static const homeRoot = '/';
  static const chooseStationRoot = '/choose_station';
  static const settingsRoot = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoot:
        return MaterialPageRoute(builder: (_) => const TimerScreen());
      case chooseStationRoot:
        return MaterialPageRoute(builder: (_) => const ChooseStationScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
          body: Center(child: Text('Нет рута для ${settings.name}')),
        )
        );
    }
  }
}