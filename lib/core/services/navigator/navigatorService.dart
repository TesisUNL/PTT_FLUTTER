import 'package:flutter/material.dart';

class NavigatorService {
  static final NavigatorService instance = NavigatorService._internal();

  factory NavigatorService() {
    return instance;
  }

  NavigatorService._internal();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateToLogin() {
    navigatorKey.currentState?.pushReplacementNamed('/');
  }
}
