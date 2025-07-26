import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/schedule_provider.dart';

class ChooseDirectionButtons extends StatelessWidget {
  const ChooseDirectionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleProvider>(context);
    final isToFirst = provider.selectedDirection == 'to_first';
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DirectionButton(
            isActive: isToFirst,
            label: 'На ботанику',
            onTap: () => provider.selectDirection('to_first'),
          ),
          _DirectionButton(
            isActive: !isToFirst,
            label: 'На Пр. Космонавтов',
            onTap: () => provider.selectDirection('to_last'),
          ),
        ],
      ),
    );
  }
}

class _DirectionButton extends StatelessWidget {
  final bool isActive;
  final String label;
  final VoidCallback onTap;

  const _DirectionButton({
    required this.isActive,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
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
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}