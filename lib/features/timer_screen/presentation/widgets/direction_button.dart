import 'package:flutter/material.dart';
import 'package:metro_schedule/core/providers/schedule_provider.dart';
import 'package:metro_schedule/data/models/direction.dart';

class DirectionButton extends StatelessWidget {
  final Direction direction;
  final String label;
  final ScheduleProvider provider;

  const DirectionButton({
    super.key,
    required this.direction,
    required this.label,
    required this.provider,
  });

  bool get isActive => provider.selectedDirection == direction;
  bool get isEnabled => provider.isDirectionAvailable(direction);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      enabled: isEnabled,
      selected: isActive,
      child: InkWell(
        borderRadius: BorderRadius.zero,
        onTap: isEnabled ? () => provider.selectDirection(direction) : null,
        highlightColor: Colors.transparent, // Убираем эффект highlight
        splashColor: Colors.transparent, // Убираем эффект splash
        hoverColor: Colors.transparent, // Убираем эффект при наведении
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isActive
                ? colorScheme.primary.withOpacity(0.12)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isActive
                    ? colorScheme.primary
                    : colorScheme.outlineVariant.withOpacity(0.3),
                width: 2.0,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: textTheme.titleMedium?.copyWith(
                color: isActive
                    ? colorScheme.primary
                    : isEnabled
                    ? colorScheme.onSurface
                    : colorScheme.onSurface.withOpacity(0.38),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}