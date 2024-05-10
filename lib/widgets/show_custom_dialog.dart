import 'package:flutter/material.dart';
import 'package:vpn/screens/go_pro_page/widgets/custom_buy_button.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/spaces.dart';
import 'package:vpn/widgets/custom_buttom.dart';

class ShowDialogOk extends StatelessWidget {
  final String? text;
  final String? title;

  const ShowDialogOk({super.key, this.text, this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(title ?? 'Loading', style: BS.sb24.apply(color: BC.black)),
          Space.h8,
          Text(text ?? 'Please wait', style: BS.med16.apply(color: BC.black), textAlign: TextAlign.center),
        ],
      ),
      actions: [
        CustomButtonGray(
          onTap: () => Navigator.pop(context),
          text: 'Ok',
        )
      ],
    );
  }
}
