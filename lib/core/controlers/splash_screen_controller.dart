import 'package:get/get.dart';
import 'package:ptt_rtmb/features/authentication/onboarding/onboarding_screen.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));

    animate.value = true;

    await Future.delayed(const Duration(milliseconds: 3000));

    Get.to(OnBoardingScreen());
  }
}
