import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptt_rtmb/core/controlers/register_screen_controller.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    late String name = '';
    late String email = '';
    late String phoneNumber = '';
    late String password = '';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text(tFullName),
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              onChanged: (value) => {
                name = value,
              },
            ),
            const SizedBox(
              height: tFormHeight - 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(tEmail),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              onChanged: (value) => {
                email = value,
              },
            ),
            const SizedBox(
              height: tFormHeight - 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(tPhoneNo),
                prefixIcon: Icon(Icons.numbers),
              ),
              onChanged: (value) => {
                phoneNumber = value,
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
                      icon: Icon(registerController.isObscure.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        registerController.isObscure.value =
                            !registerController.isObscure.value;
                      },
                    )),
                obscureText: registerController.isObscure.value,
                enableSuggestions: false,
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            const SizedBox(
              height: tFormHeight - 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    registerController.registerLogic(
                        email, password, name, phoneNumber);
                  },
                  child: Text(tRegister.toUpperCase())),
            )
          ],
        ),
      ),
    );
  }
}
