import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/constants.dart';
import 'package:ptt_rtmb/core/constants/sizes.dart';

class PttAppTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: const TextTheme(
        headline2: TextStyle(
            fontFamily: 'Poppins', color: Colors.black87, fontSize: 20),
        subtitle2: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold),
        headline3: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black87,
            fontWeight: FontWeight.bold),
      ),
      outlinedButtonTheme: (OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            primary: Constants.tAppSecondaryColor,
            shape: const RoundedRectangleBorder(),
            side: BorderSide(color: Constants.tAppSecondaryColor),
            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
      )),
      elevatedButtonTheme: (ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Constants.tAppSecondaryColor,
            onPrimary: Constants.tAppPrimaryColor,
            side: BorderSide(color: Constants.tAppSecondaryColor),
            elevation: 0,
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
      )),
      primarySwatch: Colors.deepPurple);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        headline2: TextStyle(
            fontFamily: 'Poppins', color: Colors.white70, fontSize: 20),
        subtitle2: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white60,
            fontSize: 14,
            fontWeight: FontWeight.bold),
        headline3: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black87,
            fontWeight: FontWeight.bold),
      ),
      outlinedButtonTheme: (OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            primary: Constants.tAppPrimaryColor,
            shape: const RoundedRectangleBorder(),
            side: BorderSide(color: Constants.tAppPrimaryColor),
            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
      )),
      elevatedButtonTheme: (ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Constants.tAppPrimaryColor,
            onPrimary: Constants.tAppSecondaryColor,
            side: BorderSide(color: Constants.tAppPrimaryColor),
            elevation: 0,
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
      )),
      primarySwatch: Colors.deepOrange);
}
