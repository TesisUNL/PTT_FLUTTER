import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("O"),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: const Image(
                image: AssetImage(tGoogleImage),
                width: 20,
              ),
              onPressed: () {},
              label: const Text(tSingInWithGoogle)),
        ),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        TextButton(
            onPressed: () {},
            child: Text.rich(TextSpan(
                text: tDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyText1,
                children: const [
                  TextSpan(
                      text: tMakeARegister,
                      style: TextStyle(color: Colors.blue))
                ])))
      ],
    );
  }
}
