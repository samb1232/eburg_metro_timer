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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? () => provider.selectDirection(direction) : null,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isActive
                      ? colorScheme.primary
                      : colorScheme.outlineVariant.withValues(alpha: 0.3),
                  width: 2.0,
                ),
              ),
            ),
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  color: isActive
                      ? colorScheme.primary
                      : isEnabled
                      ? colorScheme.onSurface
                      : colorScheme.onSurface.withValues(alpha: 0.3),
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
