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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: DirectionButton(
              direction: Direction.toFirst,
              label: 'Пр. Космонавтов',
              provider: provider,
            ),
          ),
          const SizedBox(width: 1),
          Expanded(
            child: DirectionButton(
              direction: Direction.toLast,
              label: 'Ботаническая',
              provider: provider,
            ),
          ),
        ],
      ),
    );
  }
}
