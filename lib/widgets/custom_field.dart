import 'package:flutter/material.dart';
import 'package:vpn/style.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String? text;
  final bool? isEmailField;
  final Function()? onTap;
  final bool? isShowPassword;
  final TextInputType? keyboardType;

  const CustomField(
      {super.key,
      required this.controller,
      this.text,
      this.isEmailField = false,
      this.keyboardType,
      this.isShowPassword = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: (onTap != null) ? isShowPassword == false : false,
        controller: controller,
        keyboardType: keyboardType,
        style: BS.reg15,
        cursorColor: BC.darkGrey,
        decoration: InputDecoration(
          suffixIcon: onTap == null
              ? null
              : InkWell(
                  onTap: onTap,
                  child: Icon(
                    isShowPassword == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
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
              )),
          fillColor: BC.lightGrey,
          hintText: text,
          hintStyle: BS.reg15,
        ));
  }
}
