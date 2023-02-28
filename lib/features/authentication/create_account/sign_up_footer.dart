import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptt_rtmb/core/constants/sizes.dart';
import 'package:ptt_rtmb/core/constants/text_strings.dart';
import 'package:ptt_rtmb/core/services/auth/auth_google_service.dart';
import '../../../core/constants/image_strings.dart';
import '../login/login.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthClass authClass = AuthClass();
    return Column(
      children: [
        const Text("O"),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              onPressed: () async {
                await authClass.googleSignIn(context);
              },
              icon: const Image(
                image: AssetImage(tGoogleImage),
                width: 20.0,
              ),
              label: const Text(tSingInWithGoogle)),
        ),
        TextButton(
            onPressed: () {
              Get.to(() => const Login());
            },
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: tAlreadyHaveAnAccount,
                  style: Theme.of(context).textTheme.bodyText1),
              TextSpan(text: tLogin.toUpperCase())
            ])))
      ],
    );
  }
}
