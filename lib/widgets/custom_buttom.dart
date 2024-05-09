import 'package:flutter/material.dart';
import 'package:vpn/style.dart';

class CustomButtonGray extends StatelessWidget {
  const CustomButtonGray({this.text, this.onTap, super.key, this.color});

  final String? text;
  final void Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BRadius.r10,
      color: color ?? BC.green1,
      child: InkWell(
          borderRadius: BRadius.r10,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Center(child: Text(text ?? 'Next', style: BS.sb15)),
          )),
    );
  }
}

class CustomButtonBlack extends StatelessWidget {
  const CustomButtonBlack({this.text, this.onTap, super.key});

  final String? text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BRadius.r10,
          color: BC.white,
          border: Border.all(
            color: BC.green1,
            width: 1,
          )),
      child: InkWell(
          borderRadius: BRadius.r10,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Center(child: Text(text ?? 'Next', style: BS.sb15.apply(color: BC.green1))),
          )),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({this.text, this.onTap, super.key});

  final String? text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Text(text ?? 'Next', style: BS.med13));
  }
}
