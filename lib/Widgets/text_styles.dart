import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle boldBlack({double? fontSize, double? color}) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.bold, fontFamily: "Poppins");
  }

  static TextStyle regularHeader({double? fontSize, required Color color}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        fontFamily: "Poppins");
  }

  static TextStyle someText({double? fontSize, required Color color}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        fontFamily: "Poppins");
  }

  static TextStyle primaryTextStyle({double? fontSize, required Color color, FontWeight? fontWeight}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontFamily: "Poppins");
  }

  static descriptionStyle({required int fontSize}) {}
}
