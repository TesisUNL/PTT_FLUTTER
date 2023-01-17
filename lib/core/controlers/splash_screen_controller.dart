import 'package:get/get.dart';
import 'package:ptt_rtmb/features/login/login.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));

    animate.value = true;

    await Future.delayed(const Duration(milliseconds: 2500));

    Get.to(Login());
  }
}
