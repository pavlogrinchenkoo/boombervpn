import 'package:flutter/material.dart';
import 'package:vpn/style.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: BC.purple,
        strokeWidth: 3,
      ),
    );
  }
}
