import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class WaitingFunction extends StatelessWidget {
  const WaitingFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: NutsActivityIndicator(
        radius: 35,
        activeColor: Color.fromARGB(255, 8, 136, 241),
        tickCount: 12,
        startRatio: 0.55,
        animationDuration: Duration(milliseconds: 400),
      ),
    );
  }
}
