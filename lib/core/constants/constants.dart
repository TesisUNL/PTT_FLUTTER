import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/theme.dart';

import '../../enviroment.dart';

class Constants {
  // api Request
  static String api_url = Enviroment.api_host;
  static String api_scheme = Enviroment.api_scheme;
  static String api_part = Enviroment.api_part;

  // App
  static String appName = "Ruta Turística Mancomunidad Bosque Seco";

  static ThemeData lightTheme = PttAppTheme.lightTheme;

  static ThemeData darkTheme = PttAppTheme.darkTheme;

  //App Constant Colors
  static Color tOnBoardingPageWallColor =
      const Color.fromARGB(255, 168, 164, 175);
  static Color tOnBoardingPageBirdColor =
      const Color.fromARGB(255, 136, 196, 139);
  static Color tOnBoardingPageBagColor =
      const Color.fromARGB(255, 128, 121, 121);

  static Color tAppPrimaryColor = const Color.fromARGB(255, 188, 184, 190);
  static Color tAppSecondaryColor = const Color.fromARGB(255, 94, 89, 89);

  static Color tAppWhiteColor = Colors.white;
  static Color tAppBlackColor = const Color.fromARGB(255, 53, 52, 52);
}
