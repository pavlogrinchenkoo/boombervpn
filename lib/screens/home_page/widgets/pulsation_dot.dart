import 'package:flutter/material.dart';
import 'package:pulsator/pulsator.dart';
import 'package:vpn/style.dart';

class Pulsat extends StatelessWidget {
  const Pulsat({super.key});

  @override
  Widget build(BuildContext context) {
    return Pulsator(
      style: PulseStyle(
        borderColor: BC.purple,
        borderWidth: 2,
        color: BC.darkGrey,
        // fadeOpacity: false,
      ),
      count: 4,
      duration: const Duration(seconds: 3),
      repeat: 0,
      startFromScratch: true,
      autoStart: true,
      fit: PulseFit.cover,
    );
  }
}
