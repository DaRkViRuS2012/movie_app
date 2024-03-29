import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color gradiantLightColor = Color(0xFF5A90D7);
  static const Color gradiantDarkColor = Color(0xFF323D8F);
  static const Color lightWhite = Color(0x99FFFFFF);
  static const gradiant_decoration = LinearGradient(
      colors: [gradiantLightColor, gradiantDarkColor],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 1.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);

  static const shadow = BoxShadow(
    color: Colors.black,
    blurRadius: 20.0, // has the effect of softening the shadow
    offset: Offset(
      0.0, // horizontal, move right 10
      15.0, // vertical, move down 10
    ),
  );

  static LinearGradient gradiantFromColors(String color1, String color2) {
    return LinearGradient(
        colors: [Color(hexToInt(color1)), Color(hexToInt(color2))],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 1.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp);
  }

  static int hexToInt(String hex) {
    int val = 0;
    hex = 'FF' + hex;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }
}
