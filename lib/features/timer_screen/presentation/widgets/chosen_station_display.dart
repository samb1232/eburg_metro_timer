import 'package:flutter/material.dart';
import 'package:metro_schedule/navigation/app_router.dart';

class ChosenStationDisplay extends StatelessWidget {
  final String selectedStation;

  const ChosenStationDisplay(this.selectedStation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //
      // @todo #8: Add feature: If you click on station name,
      //  you can choose another station from dropdown
      //
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.chooseStationRoot);
          },
          child: Text(
            selectedStation,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}
