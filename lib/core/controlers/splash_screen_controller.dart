import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ptt_rtmb/core/constants/secureStorage.dart';
import 'package:ptt_rtmb/features/authentication/onboarding/onboarding_screen.dart';
import 'package:ptt_rtmb/features/authentication/welcome/welcome.dart';
import 'package:ptt_rtmb/features/layout/main_screen.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();
  RxBool animate = false.obs;
  FlutterSecureStorage _storage = FlutterSecureStorage();

  Future startAnimation() async {
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
                    {Get.to(MainScreen())}
                  else
                    {Get.to(const WelcomeScreen())}
                }
              else
                {Get.to(const OnBoardingScreen())}
            });
  }
}
