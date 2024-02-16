import 'package:flutter/material.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/spaces.dart';

class VipIndicator extends StatefulWidget {
  const VipIndicator({super.key});

  @override
  State<VipIndicator> createState() => _VipIndicatorState();
}

class _VipIndicatorState extends State<VipIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween(begin: 0.0, end: 0.7).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 128,
          height: 128,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: BC.white,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Expire', style: BS.reg12),
                  Space.h10,
                  Center(child: Text('248', style: BS.sb24)),
                  Space.h10,
                  Text('Days', style: BS.reg12),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                top: 0,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: _animation.value,
                      backgroundColor: BC.lightGrey.withOpacity(0.2),
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(BC.yellow),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Space.h8,
        Text('Your are secured Until', style: BS.sb14),
        Space.h8,
        Text('Oct 22nd, 2021', style: BS.sb14),
      ],
    );
  }
}
