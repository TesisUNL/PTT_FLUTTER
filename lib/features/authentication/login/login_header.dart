import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/image_strings.dart';
import 'package:ptt_rtmb/core/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image(
        image: const AssetImage(tAppWelcomeScreenImage),
        height: size.height * 0.2,
      ),
      Text(
        tLoginTitle,
        style: Theme.of(context).textTheme.headline4,
      ),
      Text(
        tLoginSubtitle,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ]);
  }
}
