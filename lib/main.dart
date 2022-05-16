import 'package:flutter/material.dart';
import 'package:ptt_rtmb/features/login/login.dart';
import 'package:ptt_rtmb/core/constants/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins'
      ),
      darkTheme: Constants.darkTheme,
      home: Login(),
    );
  }
}