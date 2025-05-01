import 'package:flutter/material.dart';
import 'package:restology/app/constant/custom_colors.dart';

class CustomTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.primary,
    scaffoldBackgroundColor: CustomColors.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: CustomColors.primary,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: CustomColors.primary,
    scaffoldBackgroundColor: CustomColors.blackColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: CustomColors.primary,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
