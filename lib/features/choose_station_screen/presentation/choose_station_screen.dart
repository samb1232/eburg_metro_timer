import 'package:flutter/material.dart';
import 'package:metro_schedule/core/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

class ChooseStationScreen extends StatelessWidget {
  const ChooseStationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Выберите станцию',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        backgroundColor: colorScheme.primary,
      ),
      body: _buildBody(context, scheduleProvider, colorScheme),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ScheduleProvider provider,
    ColorScheme colorScheme,
  ) {
    if (provider.isLoading) {
      return Center(
        child: CircularProgressIndicator(color: colorScheme.primary),
      );
    }

    if (provider.loadError != null) {
      return Center(
        child: Text(
          'Ошибка: ${provider.loadError}',
          style: TextStyle(color: colorScheme.error, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (provider.stationOrder.isEmpty) {
      return Center(
        child: Text(
          'Нет доступных станций',
          style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: provider.stationOrder.length,
      itemBuilder: (context, index) {
        final stationNumber = provider.stationOrder[index];
        final stationName = provider.getStationName(stationNumber);
        final isSelected = provider.selectedStationNumber == stationNumber;

        return ListTile(
          title: Text(
            stationName,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          trailing: isSelected
              ? Icon(Icons.check, color: colorScheme.primary)
              : null,
          onTap: () {
            provider.selectStation(stationNumber);
            Navigator.pop(context, stationName);
          },
          tileColor: isSelected ? colorScheme.primary.withValues(alpha: 0.1) : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      },
    );
  }
}
