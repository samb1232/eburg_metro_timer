import 'package:flutter/material.dart';

class ChosenStationDisplay extends StatelessWidget {
  const ChosenStationDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // @todo #1: We should take and add actual values instead of placeholders
    return Column(
      children: [
        Text('Уралмаш', style: Theme.of(context).textTheme.headlineLarge),
        Text('В строну м. Ботаническая', style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
