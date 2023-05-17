import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/constants.dart';
import 'package:ptt_rtmb/core/constants/sizes.dart';

class PttAppTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: const TextTheme(
        displayMedium: TextStyle(
            fontFamily: 'Poppins', color: Colors.black87, fontSize: 20),
        titleSmall: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black87,
            fontWeight: FontWeight.bold),
      ),
      outlinedButtonTheme: (OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: Constants.tAppSecondaryColor, shape: const RoundedRectangleBorder(),
            side: BorderSide(color: Constants.tAppSecondaryColor),
            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
      )),
      elevatedButtonTheme: (ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Constants.tAppPrimaryColor, backgroundColor: Constants.tAppSecondaryColor,
            side: BorderSide(color: Constants.tAppSecondaryColor),
            elevation: 0,
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
      )),
      inputDecorationTheme: (InputDecorationTheme(
          border: const OutlineInputBorder(),
          prefixIconColor: Constants.tAppSecondaryColor,
          floatingLabelStyle: TextStyle(color: Constants.tAppSecondaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 2, color: Constants.tAppSecondaryColor),
          ))),
      primarySwatch: Colors.deepPurple);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        displayMedium: TextStyle(
            fontFamily: 'Poppins', color: Colors.white70, fontSize: 20),
        titleSmall: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white60,
            fontSize: 14,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black87,
            fontWeight: FontWeight.bold),
      ),
      outlinedButtonTheme: (OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: Constants.tAppPrimaryColor, shape: const RoundedRectangleBorder(),
            side: BorderSide(color: Constants.tAppPrimaryColor),
            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
      )),
      elevatedButtonTheme: (ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Constants.tAppSecondaryColor, backgroundColor: Constants.tAppPrimaryColor,
            side: BorderSide(color: Constants.tAppPrimaryColor),
            elevation: 0,
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
      )),
      inputDecorationTheme: (InputDecorationTheme(
          border: const OutlineInputBorder(),
          prefixIconColor: Constants.tAppPrimaryColor,
          floatingLabelStyle: TextStyle(color: Constants.tAppPrimaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Constants.tAppPrimaryColor),
          ))),
      primarySwatch: Colors.deepOrange);
}
