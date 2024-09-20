import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color textColor = HexColor('#121712');
  static Color background = HexColor('#ffffff');
  static Color background1 = HexColor('#E5E5EA');
  static Color contrastColor1 = HexColor('#0055D3');
  static Color contrastColor2 = HexColor('#0085FF');
}

Duration defaultDuration = Duration(milliseconds: 400);

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
