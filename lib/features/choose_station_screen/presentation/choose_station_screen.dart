import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/schedule_provider.dart';

class ChooseStationScreen extends StatefulWidget {
  const ChooseStationScreen({super.key});

  @override
  State<ChooseStationScreen> createState() => _ChooseStationScreenState();
}

class _ChooseStationScreenState extends State<ChooseStationScreen> {
  @override
  void initState() {
    super.initState();
    final scheduleProvider = Provider.of<ScheduleProvider>(
      context,
      listen: false,
    );
    scheduleProvider.loadSchedules();
  }

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
      return Center(child: Text('Error: ${provider.loadError}'));
    }

    final stations = provider.schedules.keys.toList();
    if (stations.isEmpty) {
      return const Center(child: Text('Нет доступных станций'));
    }

    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final stationName = stations[index];
        return ListTile(
          title: Text(stationName),
          onTap: () {
            provider.selectStation(stationName);
            Navigator.pop(context, stationName);
          },
        );
      },
    );
  }
}
