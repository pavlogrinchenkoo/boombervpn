import 'package:flutter/material.dart';

class ThemeColors {
  static const Color green = Color(0xff65C467);
  static const Color white = Color(0xffFAFAFA);
  static const Color black = Color(0xff000000);
  static const Color grey = Color(0xffAEAEAE);
  static const Color darkGrey = Color(0xff232026);
  static const Color lightGrey = Color(0xffB5AEBE);
  static const Color purple = Color(0xff6622CC);
  static const Color braun = Color(0xffB7970A);
  static const Color yellow = Color(0xffFFD006);
  static const Color blue = Color(0xff123698);
  static const Color lightGreen = Color(0xff4FA6A9);
}

abstract class BC {
  static Color get green => ThemeColors.green;
  static Color get white => ThemeColors.white;
  static Color get black => ThemeColors.black;
  static Color get grey => ThemeColors.grey;
  static Color get darkGrey => ThemeColors.darkGrey;
  static Color get lightGrey => ThemeColors.lightGrey;
  static Color get purple => ThemeColors.purple;
  static Color get braun => ThemeColors.braun;
  static Color get yellow => ThemeColors.yellow;
  static Color get blue => ThemeColors.blue;
  static Color get lightGreen => ThemeColors.lightGreen;
}

abstract class BS {
// TODO otstup

  static TextStyle get bold50 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 50.0,
    fontWeight: FontWeight.w700,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get bold28 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get bold24 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get bold16 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get bold12 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get sb15 => TextStyle(
    fontFamily: 'Sora',
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.grey,
  );

  static TextStyle get sb14 => TextStyle(
    fontFamily: 'Sora',
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 17.0 / 16.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get sb24 => TextStyle(
    fontFamily: 'Sora',
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.black,
  );

  static TextStyle get med24 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get med20 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get med18 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get med16 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get med10 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );
// TODO otstup


  static TextStyle get reg18 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get reg15 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.darkGrey,
  );

  static TextStyle get reg14 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 25.0 / 24.0,
    letterSpacing: -0.02,
    color: BC.white,
  );

  static TextStyle get reg13 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    height: 16.0 / 16.0,
    letterSpacing: -0.02,
    color: BC.purple,
  );

  static TextStyle get reg12 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 16.0 / 16.0,
    letterSpacing: -0.02,
    color: BC.grey,
  );
}

abstract class BDuration {
  static Duration get d200 => const Duration(milliseconds: 200);
}

abstract class BRadius {
  static BorderRadius get r50 => const BorderRadius.all(Radius.circular(50));
  static BorderRadius get r30 => const BorderRadius.all(Radius.circular(30));
  static BorderRadius get r20 => const BorderRadius.all(Radius.circular(20));
  static BorderRadius get r18 => const BorderRadius.all(Radius.circular(18));
  static BorderRadius get r16 => const BorderRadius.all(Radius.circular(16));
  static BorderRadius get r10 => const BorderRadius.all(Radius.circular(10));
}

abstract class BShadow {
  static List<BoxShadow> get light => [
        BoxShadow(
            color: BC.green.withOpacity(0.1),
            blurRadius: 60,
            offset: const Offset(0, 2))
      ];
}
