import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryColor = appBlue;

  static const Color appBlue = const Color.fromRGBO(0, 158, 245, 1.0); //priary
  // static const Color   appBlue = Colors.blue; //priary

  static const Color darkGey = const Color(0xff7e7e7e); //priary
  static const Color listBlue = const Color(0xffb8dffd); //priary
  static const Color scaffoldBGColor = const Color(0xfff3f7fa); //priary
  // static const Color   scaffoldBGColor = const Color(0xfff0f0f0); //priary

/*
  static const Color   appMediumRed = const Color(0xFFF86671); //priary
  static const Color   appDarkRed = const Color(0xFFBA2F2F); //priary
  static const Color   appLightRed = const Color(0xFFEE8E9E); //priary
  static const Color   ultraLightBGColor = const Color(0xFFFFEEEE); //
  static const Color   lightBGColor = const Color(0xFFFFB8B8); //
  static const Color   appGrey = const Color(0xFFC4C4C4); //
  static const Color   appLightGrey = const Color(0xFFF1F1F1); //
  static const Color   appDarkGrey= const Color(0xFF828282); //
  static const Color   appBlack= const Color(0xFF100606); //
*/

  //background colors
  static const Color kGrey = Colors.grey;

  static const MaterialColor buttonTextColor =
      const MaterialColor(0xFFFF1923, const <int, Color>{
    50: primaryColor,
    100: primaryColor,
    200: primaryColor,
    300: primaryColor,
    400: primaryColor,
    500: primaryColor,
    600: primaryColor,
    700: primaryColor,
    800: primaryColor,
    900: primaryColor,
  });
}
