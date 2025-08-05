import 'package:flutter/material.dart';
import 'package:metro_schedule/core/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

class ChooseStationScreen extends StatelessWidget {
  const ChooseStationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Выберите станцию')),
      body: _buildBody(context, scheduleProvider),
    );
  }

  Widget _buildBody(BuildContext context, ScheduleProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.loadError != null) {
      return Center(child: Text('Ошибка: ${provider.loadError}'));
    }

    if (provider.stationOrder.isEmpty) {
      return const Center(child: Text('Нет доступных станций'));
    }

    return ListView.builder(
      itemCount: provider.stationOrder.length,
      itemBuilder: (context, index) {
        final stationNumber = provider.stationOrder[index];
        final stationName = provider.getStationName(stationNumber);
        return ListTile(
          title: Text(stationName),
          onTap: () {
            provider.selectStation(stationNumber);
            Navigator.pop(context, stationName);
          },
        );
      },
    );
  }
}
