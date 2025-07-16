import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'core/providers/schedule_provider.dart';
import 'data/datasources/local_data_source.dart';
import 'data/repositories/schedule_repository.dart';
import 'navigation/app_router.dart';

class MetroTimerApp extends StatelessWidget {
  const MetroTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ScheduleProvider(
            ScheduleRepository(LocalDataSource()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Таймер поездов метро Екб',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}