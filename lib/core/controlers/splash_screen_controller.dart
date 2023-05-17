import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ptt_rtmb/core/constants/secureStorage.dart';
import 'package:ptt_rtmb/features/authentication/onboarding/onboarding_screen.dart';
import 'package:ptt_rtmb/features/authentication/welcome/welcome.dart';
import 'package:ptt_rtmb/features/layout/main_screen.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();
  RxBool animate = false.obs;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future startAnimation(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));

    animate.value = true;

    await Future.delayed(const Duration(milliseconds: 3000));

    late String? token;
    late String? userId;
    await Future.delayed(
        const Duration(milliseconds: 3100),
        () async => {
              token = await _storage.read(key: SecureStorage.accessTokenKey),
              if (token != null)
                {
                  userId = await _storage.read(key: SecureStorage.userIdKey),
                  if (userId != null)
                    {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainScreen()),
                      )
                    }
                  else
                    {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                      )
                    }
                }
              else
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnBoardingScreen()),
                  )
                }
            });
  }
}
