import 'package:flutter/material.dart';
import 'package:metro_schedule/data/models/direction.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/schedule_provider.dart';

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
          _DirectionButton(
            direction: Direction.toFirst,
            label: 'На Пр. Космонавтов',
            provider: provider,
          ),
          _DirectionButton(
            direction: Direction.toLast,
            label: 'На ботанику',
            provider: provider,
          ),
        ],
      ),
    );
  }
}

class _DirectionButton extends StatelessWidget {
  final Direction direction;
  final String label;
  final ScheduleProvider provider;

  const _DirectionButton({
    required this.direction,
    required this.label,
    required this.provider,
  });

  bool get isActive => provider.selectedDirection == direction;
  bool get isEnabled => provider.isDirectionAvailable(direction);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: isEnabled ? () => provider.selectDirection(direction) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? theme.colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: isActive
                ? theme.colorScheme.onPrimary
                : isEnabled
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}