import 'package:flutter/material.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/spaces.dart';



class CustomBuyButton extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final Function() onTap;
  final String? discount;

  const CustomBuyButton(
      {super.key,
        required this.title,
        required this.price,
        required this.description,
        required this.onTap,
        this.discount});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BRadius.r30,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BRadius.r30,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [BC.braun, BC.yellow],
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: BS.med18,
            ),
            Space.w4,
            if (discount != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BRadius.r20,
                  color: BC.white,
                ),
                child: Text(
                  discount ?? '',
                  style: BS.med10.apply(color: BC.braun),
                ),
              ),
            const Spacer(),
            Text(
              price,
              style: BS.bold24,
            ),
            Space.w4,
            Text(description, style: BS.med18),
          ],
        ),
      ),
    );
  }
}

class GrayButton extends StatelessWidget {
  final Function()? onTap;
  final String title;

  const GrayButton({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BRadius.r30,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration:
        BoxDecoration(borderRadius: BRadius.r30, color: BC.darkGrey),
        child: Center(
          child: Text(
            title,
            style: BS.bold16,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
