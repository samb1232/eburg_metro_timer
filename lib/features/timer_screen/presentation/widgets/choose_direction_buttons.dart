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
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DirectionButton(
            direction: Direction.toFirst,
            label: 'На Пр. Космонавтов',
            provider: provider,
          ),
          const SizedBox(width: 4),
          DirectionButton(
            direction: Direction.toLast,
            label: 'На ботанику',
            provider: provider,
          ),
        ],
      ),
    );
  }
}
