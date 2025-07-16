import 'package:flutter/material.dart';

class NavButtonsDisplay extends StatelessWidget {
  const NavButtonsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.train),
          onPressed: () => Navigator.pushNamed(context, '/station_picker'),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.pushNamed(context, '/settings'),
        ),
      ],
    );
  }
}
