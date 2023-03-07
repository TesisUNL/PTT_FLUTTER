import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ptt_rtmb/features/layout/main_screen.dart';
import '../constants/secureStorage.dart';
import '../models/user/auth_user.dart';
import '../services/auth/auth_local_services.dart';
import '../services/auth/password_recovery.dart';

class LoginController extends GetxController {
  static LoginController get find => Get.find();
  RxBool isObscure = true.obs;
  FlutterSecureStorage _storage = FlutterSecureStorage();

  loginLogic(String userEmail, String userPassword) async {
    if (userEmail.isNotEmpty && userPassword.isNotEmpty) {
      if (!GetUtils.isEmail(userEmail)) {
        return Get.snackbar("Error", "Ingrese un Email Válido");
      }
      try {
        AuthUser? userLogged = await postLogin(userEmail, userPassword);
        if (userLogged != null) {
          await _storage.write(
              key: SecureStorage.accessTokenKey, value: userLogged.accessToken);
          await _storage.write(
              key: SecureStorage.userIdKey, value: userLogged.user.id);
          Get.to(MainScreen());
        }
      } on Exception catch (e) {
        print(e.toString());
        Get.snackbar('Error', 'Credenciales Incorrectas');
      }
    } else {
      return Get.snackbar("Error", "Ingrese todos los campos primero");
    }
  }

  forgotPasswordLogic(String email) async {
    if (email.isNotEmpty) {
      try {
        if (!GetUtils.isEmail(email)) {
          return Get.snackbar("Error", "Ingrese un Email Válido");
        }
        await postForgotPassword(email);
        Get.snackbar('Éxito', 'Se ha enviado un correo a $email');
      } on Exception catch (e) {
        print(e.toString());
        Get.snackbar('Error',
            'No se pudo enviar el correo, verifique que sea el correo registrado en nuestra aplicación');
      }
    } else {
      return Get.snackbar("Error", "Ingrese su correo primero");
    }
  }
}
