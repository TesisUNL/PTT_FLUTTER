import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/services/auth/auth_google_service.dart';
import 'package:ptt_rtmb/core/services/navigator/navigatorService.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/httpHelper.service.dart';

AppBar buildAppBar(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  var brightness = mediaQuery.platformBrightness;
  final isDarkMode = brightness == Brightness.dark;
  AuthClass authClass = AuthClass();
  final globalNavigator = NavigatorService();

  signOut() async {
    await authClass.logout();
    await HttpHelperService.deleteSession();
    globalNavigator.navigateToLogin();
  }

  const icon = CupertinoIcons.square_arrow_right;

  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
        onPressed: () async {
          await signOut();
        },
      ),
    ],
  );
}
