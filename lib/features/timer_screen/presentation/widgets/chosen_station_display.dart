import 'package:flutter/material.dart';

class ChosenStationDisplay extends StatelessWidget {
  const ChosenStationDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // @todo #2:30mxin We should use actual values instead of placeholders.
      children: [
        Text('Уралмаш', style: Theme.of(context).textTheme.headlineLarge),
        Text('В строну м. Ботаническая', style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
