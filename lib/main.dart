import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ptt_rtmb/features/authentication/create_account/register.dart';
import 'core/constants/constants.dart';
import 'features/authentication/splash/splash.dart';
import 'firebase_options.dart';
import 'package:flutter_config/flutter_config.dart';

Future<void> main() async {
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
