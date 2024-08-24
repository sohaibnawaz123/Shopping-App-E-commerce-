import 'package:flutter/material.dart';

class AppConstants {
  static String appMainName = 'E-commerce';
  static String appPowerBy = "Sohaib|Rights Reserved 2024";
  static const appMainColor = Color(0xFF023047);
  static const appSecondryColor = Color(0xFF219ebc);
  static const appTextColor = Color(0xFFFFFFFF);
  static const appStatusBarColor = Color(0xFF8ecae6);
  static const appOrangeColor = Color(0xFFfb8500);
  static const appyellowColor = Color(0xFFffb703);
  static const appErrorColor = Color.fromARGB(255, 221, 77, 77);
  static const appSuccessColor = Color.fromARGB(255, 35, 82, 49);
}

TextStyle mainHeading(double size, Color color, {FontWeight fontweight = FontWeight.w300,TextDecoration decoration = TextDecoration.none,Color dcolor = AppConstants.appTextColor}) {
  return TextStyle(
      fontFamily: "Akaya",
      color: color,
      fontSize: size,
      fontWeight: fontweight,
      decoration: decoration,
    decorationColor: dcolor);
}

TextStyle tittle(double size, Color color,{TextDecoration decoration = TextDecoration.none,Color dcolor = AppConstants.appTextColor}) {
  return TextStyle(
    fontFamily: "poppins-M",
    color: color,
    fontSize: size,
    decoration: decoration,
    decorationColor: dcolor
  );
}

TextStyle appText(double size, Color color,{TextDecoration decoration = TextDecoration.none,Color dcolor = AppConstants.appTextColor}) {
  return TextStyle(
    fontFamily: "poppins-R",
    color: color,
    fontSize: size,
    decoration: decoration,
    decorationColor: dcolor
  );
}
