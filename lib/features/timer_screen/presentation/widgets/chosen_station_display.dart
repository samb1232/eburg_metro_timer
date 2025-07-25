import 'package:flutter/material.dart';

class ChosenStationDisplay extends StatelessWidget {
  const ChosenStationDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //
      // @todo #2: Use actual values from params instead of text placeholders
      //
      //
      // @todo #8: Add feature: If you click on station name,
      //  you can choose another station from dropdown
      //
      children: [
        Text('Уралмаш', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
