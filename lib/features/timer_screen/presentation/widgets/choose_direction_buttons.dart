import 'package:flutter/material.dart';
import 'package:metro_schedule/core/providers/schedule_provider.dart';
import 'package:metro_schedule/data/models/direction.dart';
import 'package:provider/provider.dart';
import 'direction_button.dart';

class ChooseDirectionButtons extends StatelessWidget {
  const ChooseDirectionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer, // Фон контейнера из темы
        borderRadius: BorderRadius.circular(16), // Скругление углов контейнера
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: DirectionButton(
              direction: Direction.toFirst,
              label: 'На Пр. Космонавтов',
              provider: provider,
            ),
          ),
          Expanded(
            child: DirectionButton(
              direction: Direction.toLast,
              label: 'На ботанику',
              provider: provider,
            ),
          ),
        ],
      ),
    );
  }
}
