import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/image_strings.dart';
import 'package:ptt_rtmb/core/constants/sizes.dart';
import 'package:ptt_rtmb/core/constants/text_strings.dart';
import 'package:ptt_rtmb/features/authentication/login/login_form.dart';
import 'package:ptt_rtmb/core/utils/widgets/form/form_header.dart';

import 'login_footer.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormHeaderWidget(
                      image: tAppWelcomeScreenImage,
                      title: tLoginTitle,
                      subTitle: tLoginSubtitle),
                  LoginFormWidget(),
                  LoginFooterWidget(),
                ]),
          ),
        ),
      ),
    );
  }
}
