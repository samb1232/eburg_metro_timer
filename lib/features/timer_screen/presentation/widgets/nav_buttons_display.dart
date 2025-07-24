import 'package:flutter/material.dart';

import '../../../../navigation/app_router.dart';

class NavButtonsDisplay extends StatelessWidget {
  const NavButtonsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // todo #5: replace todo buttons with something more useful
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.train),
          onPressed: () => Navigator.pushNamed(context, AppRouter.chooseStationRoot),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.pushNamed(context, AppRouter.settingsRoot),
        ),
      ],
    );
  }
}
