import 'package:flutter/material.dart';

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
      primarySwatch: Colors.deepOrange);
}
