import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/theme.dart';

import '../../enviroment.dart';

class Constants {
  // api Request
  static String api_url = Enviroment.api_host;
  static String api_scheme = Enviroment.api_scheme;
  static String api_part = Enviroment.api_part;

  // App
  static String appName = "Mancomunidad Bosque Seco Tourist's Routes";

  //Colors for theme
  static Color lightPrimary = ConstantsTheme.lightPrimary;
  static Color darkPrimary = ConstantsTheme.darkPrimary;
  static Color? lightAccent = ConstantsTheme.lightAccent;
  static Color darkAccent = ConstantsTheme.darkAccent;
  static Color lightBG = ConstantsTheme.lightBG;
  static Color darkBG = ConstantsTheme.darkBG;
  static Color badgeColor = ConstantsTheme.badgeColor;

  static ThemeData lightTheme = ConstantsTheme.lightTheme;

  static ThemeData darkTheme = ConstantsTheme.darkTheme;
}
