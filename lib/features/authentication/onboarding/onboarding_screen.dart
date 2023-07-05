import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:ptt_rtmb/core/controlers/onboarding_screen_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final obController = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        LiquidSwipe(
          pages: obController.pages,
          liquidController: obController.controller,
          onPageChangeCallback: obController.OnPageChangeCallback,
          slideIconWidget: const Icon(Icons.arrow_back_ios),
          enableSideReveal: true,
        ),
        Positioned(
          bottom: 40,
          child: OutlinedButton(
            onPressed: () => obController.animateToNextSlide(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, side: const BorderSide(color: Colors.black26),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 163, 157, 157),
                    shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward_ios)),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: TextButton(
            onPressed: () => obController.skip(context),
            child: const Text(
              "Saltar",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Obx(
          () => Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                activeIndex: obController.currentPage.value,
                count: 3,
                effect: WormEffect(
                  activeDotColor: Colors.purple.shade400,
                  dotHeight: 5.0,
                ),
              )),
        )
      ]),
    );
  }
}
