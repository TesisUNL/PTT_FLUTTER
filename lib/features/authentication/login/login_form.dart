import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ptt_rtmb/core/controlers/login_screen_controller.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/text_strings.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              labelText: tEmail,
              hintText: tEmail,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              loginController.email.value = value;
            },
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          Obx(
            () => TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fingerprint),
                  labelText: tPassword,
                  hintText: tPassword,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(loginController.isObscure.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      loginController.isObscure.value =
                          !loginController.isObscure.value;
                    },
                  )),
              obscureText: loginController.isObscure.value,
              enableSuggestions: false,
              onChanged: (value) {
                loginController.password.value = value;
              },
            ),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: const Text(tForgotPassword))),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  loginController.loginLogic();
                },
                child: Text(tLogin.toUpperCase())),
          ),
        ],
      ),
    ));
  }
}
