import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    late String email = '';
    late String password = '';
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
              email = value;
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
                password = value;
              },
            ),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    _showPasswordRecoveryModal(context);
                  },
                  child: const Text(tForgotPassword))),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  loginController.loginLogic(email, password);
                },
                child: Text(tLogin.toUpperCase())),
          ),
        ],
      ),
    ));
  }

  void _showPasswordRecoveryModal(BuildContext context) {
    final loginController = Get.put(LoginController());
    String email = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        title: const Text('Recupera tu contraseña'),
        content: Column(
          mainAxisSize:
              MainAxisSize.min, // this determines the height of the dialog
          children: [
            const Text(
                'Ingresa tu email y luego sigue los pasos indicados en el correo'),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Email',
              ),
              onChanged: (value) {
                email = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              loginController.forgotPasswordLogic(email);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
