import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pulsator/pulsator.dart';
import 'package:vpn/style.dart';

class Animation1 extends StatelessWidget {
  const Animation1({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/VPN_1.json',
    );
  }
}

class Animation2 extends StatelessWidget {
  const Animation2({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/VPN_2.json',
    );
  }
}

class Animation3 extends StatelessWidget {
  const Animation3({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/VPN_3.json',
      repeat: false,
    );
  }
}

