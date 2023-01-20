import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/widgets/onboarding_widget_model.dart';
import '../../constants/sizes.dart';

class OnboardingPageWidget extends StatelessWidget {
  const OnboardingPageWidget({
    Key? key,
    required this.onboardingModel,
  }) : super(key: key);

  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(tDefaultSize),
      color: onboardingModel.bgColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: AssetImage(onboardingModel.image),
              height: (size.height * 0.49),
            ),
            Column(
              children: [
                Text(
                  onboardingModel.title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  onboardingModel.subtitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              onboardingModel.counterText,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: size.height * 0.4,
            )
          ],
        ),
      ),
    );
  }
}
