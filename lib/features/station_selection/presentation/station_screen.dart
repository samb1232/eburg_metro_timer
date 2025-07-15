import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/schedule_provider.dart';

class StationScreen extends StatelessWidget {
  const StationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Выбор станции')),
      body: FutureBuilder(
        future: scheduleProvider.loadSchedules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: scheduleProvider.schedules.length,
            itemBuilder: (context, index) {
              final stationName = scheduleProvider.schedules.keys.elementAt(index);
              return ListTile(
                title: Text(stationName),
                onTap: () {
                  scheduleProvider.selectStation(stationName);
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}