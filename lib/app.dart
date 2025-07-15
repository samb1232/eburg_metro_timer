import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'navigation/app_router.dart';

class MetroTimerApp extends StatelessWidget {
  const MetroTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Метро Таймер',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/timer',
    );
  }
}