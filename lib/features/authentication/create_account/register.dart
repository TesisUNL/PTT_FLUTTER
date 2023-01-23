import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/image_strings.dart';
import 'package:ptt_rtmb/core/constants/sizes.dart';
import 'package:ptt_rtmb/core/constants/text_strings.dart';
import 'package:ptt_rtmb/core/utils/widgets/form/form_header.dart';
import 'package:ptt_rtmb/features/authentication/create_account/sign_up_footer.dart';
import 'package:ptt_rtmb/features/authentication/create_account/sign_up_form.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FormHeaderWidget(
                    image: tAppWelcomeScreenImage,
                    title: tRegisterTitle,
                    subTitle: tRegisterSubtitle),
                SignUpFormWidget(),
                SignUpFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
