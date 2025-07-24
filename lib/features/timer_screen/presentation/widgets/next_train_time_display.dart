import 'package:flutter/material.dart';

class NextTrainTimeDisplay extends StatelessWidget {
  const NextTrainTimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // @todo #4: add real time to next train instead of text placeholder
    return Text('Следующий поезд через 5 мин',
          style: Theme.of(context).textTheme.bodyLarge);
  }
}
