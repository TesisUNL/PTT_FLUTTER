import 'package:get/state_manager.dart';

import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:ptt_rtmb/features/login/login.dart';

import '../constants/constants.dart';
import '../constants/image_strings.dart';
import '../constants/text_strings.dart';
import '../models/widgets/onboarding_widget_model.dart';
import '../utils/widgets/onboarding_widget.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get find => Get.find();
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnboardingPageWidget(
      onboardingModel: OnboardingModel(
        image: tAppOnboardingBag,
        title: tAppOnboardingTitle1,
        subtitle: tAppOnboardingSubTittle1,
        counterText: tAppOnboardingCounter1,
        bgColor: Constants.tOnBoardingPageBagColor,
      ),
    ),
    OnboardingPageWidget(
      onboardingModel: OnboardingModel(
        image: tAppOnboardingBird,
        title: tAppOnboardingTitle2,
        subtitle: tAppOnboardingSubTittle2,
        counterText: tAppOnboardingCounter2,
        bgColor: Constants.tOnBoardingPageBirdColor,
      ),
    ),
    OnboardingPageWidget(
      onboardingModel: OnboardingModel(
        image: tAppOnboardingWall,
        title: tAppOnboardingTitle3,
        subtitle: tAppOnboardingSubTittle3,
        counterText: tAppOnboardingCounter3,
        bgColor: Constants.tOnBoardingPageWallColor,
      ),
    ),
  ];

  OnPageChangeCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
  }

  skip() => controller.jumpToPage(page: 2);

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    if (nextPage == 3) {
      Get.to(Login());
    } else {
      controller.animateToPage(page: nextPage);
    }
  }
}
