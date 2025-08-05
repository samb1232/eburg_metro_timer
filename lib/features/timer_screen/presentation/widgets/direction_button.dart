import 'package:flutter/material.dart';
import 'package:metro_schedule/core/providers/schedule_provider.dart';
import 'package:metro_schedule/data/models/direction.dart';

class DirectionButton extends StatelessWidget {
  final Direction direction;
  final String label;
  final ScheduleProvider provider;

  const DirectionButton({super.key,
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
      onTap: (!isActive && isEnabled) ? () => provider.selectDirection(direction) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.primary : Colors.transparent,
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
