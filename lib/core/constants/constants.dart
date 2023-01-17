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

  static ThemeData lightTheme = PttAppTheme.lightTheme;

  static ThemeData darkTheme = PttAppTheme.darkTheme;
}
