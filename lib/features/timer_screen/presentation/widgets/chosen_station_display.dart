import 'package:flutter/material.dart';
import 'package:metro_schedule/navigation/app_router.dart';

class ChosenStationDisplay extends StatefulWidget {
  final String stationName;

  const ChosenStationDisplay({
    super.key,
    required this.stationName,
  });

  @override
  State<ChosenStationDisplay> createState() => _ChosenStationDisplayState();
}

class _ChosenStationDisplayState extends State<ChosenStationDisplay> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: () {
            Navigator.pushNamed(context, AppRouter.chooseStationRoot);
          },
          child: Transform.scale(
            scale: _isPressed ? 0.98 : 1.0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.stationName,
                    style: textTheme.displaySmall?.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: colorScheme.onSurface,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
