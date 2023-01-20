import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/sizes.dart';
import 'package:ptt_rtmb/features/authentication/login/login_header.dart';

import 'login_footer.dart';
import 'login_form.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              LoginHeaderWidget(size: size),
              const LoginFormWIdget(),
              const LoginFooterWidget(),
            ]),
          ),
        ),
      ),
    );
  }
}
