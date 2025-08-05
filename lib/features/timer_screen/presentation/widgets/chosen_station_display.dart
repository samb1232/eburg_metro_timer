import 'package:flutter/material.dart';
import 'package:metro_schedule/navigation/app_router.dart';

class ChosenStationDisplay extends StatelessWidget {
  final String stationName;

  const ChosenStationDisplay({super.key, required this.stationName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.chooseStationRoot);
          },
          child: Text(
            stationName,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}
