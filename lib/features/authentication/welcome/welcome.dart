import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/constants.dart';
import 'package:ptt_rtmb/core/constants/image_strings.dart';
import 'package:ptt_rtmb/core/constants/sizes.dart';
import 'package:ptt_rtmb/core/constants/text_strings.dart';
import 'package:ptt_rtmb/features/authentication/create_account/register.dart';
import 'package:ptt_rtmb/features/authentication/login/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          isDarkMode ? Constants.tAppBlackColor : Constants.tAppWhiteColor,
      body: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: const AssetImage(tAppWelcomeScreenImage),
                height: (height * 0.6),
              ),
              Column(
                children: [
                  Text(
                    tAppWelcomeScreenTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    tWelcomeSubTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: Text(tLogin.toUpperCase()),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SingUpScreen()),
                        );
                      },
                      child: Text(tRegister.toUpperCase()),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
