import 'package:flutter/material.dart';
import 'package:vpn/utils/spaces.dart';

class CustomIcon extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const CustomIcon({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Space.h4,
        ],
      ),
    );
  }
}