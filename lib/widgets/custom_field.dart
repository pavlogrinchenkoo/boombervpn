import 'package:flutter/material.dart';
import 'package:vpn/style.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String? text;
  final bool? isEmailField;
  final  TextInputType? keyboardType;

  const CustomField({super.key, required this.controller, this.text, this.isEmailField = false, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: BS.reg15,
        cursorColor: BC.darkGrey,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          border: OutlineInputBorder(
              borderRadius: BRadius.r10,
              borderSide: const BorderSide(width: 0)),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BRadius.r10,
              borderSide: const BorderSide(
                width: 0,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BRadius.r10,
            borderSide: const BorderSide(
              width: 0,
            )
          ),
          fillColor: BC.lightGrey,
          hintText: text,
          hintStyle: BS.reg15,
        ));
  }
}
