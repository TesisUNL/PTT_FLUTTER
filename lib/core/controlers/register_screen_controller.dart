import 'package:get/get.dart';
import 'package:ptt_rtmb/core/controlers/login_screen_controller.dart';
import 'package:ptt_rtmb/features/authentication/login/login.dart';
import '../models/user/user.dart';
import '../services/auth/register_service.dart';

class RegisterController extends GetxController {
  static RegisterController get find => Get.find();
  RxBool isObscure = true.obs;

  registerLogic(String userEmail, String userPassword, String userName,
      String userPhoneNumber,
      {String? userSocialToken, String? userImageUrl}) async {
    if (userEmail.isNotEmpty &&
        userPassword.isNotEmpty &&
        userName.isNotEmpty &&
        userPhoneNumber.isNotEmpty) {
      if (!GetUtils.isEmail(userEmail)) {
        return Get.snackbar("Error", "Ingrese un Email Válido");
      }
      try {
        if (userSocialToken != null) {
          final loginController = Get.put(LoginController());
          User? createdUser = await postRegister(
              userEmail, userPassword, userName, userPhoneNumber,
              authSocialToken: userSocialToken, photoUrl: userImageUrl);
          if (createdUser != null) {
            Get.snackbar('Éxito', 'Usuario Creado Correctamente');
            await Future.delayed(
                const Duration(milliseconds: 800),
                () async => {
                      await loginController.loginLogic(userEmail, userPassword),
                    });
          } else {
            Get.snackbar('Error', 'Ocurrió un error durante la creación');
          }
        } else {
          User? createdUser = await postRegister(
              userEmail, userPassword, userName, userPhoneNumber);
          if (createdUser.id.isNotEmpty) {
            Get.snackbar('Éxito', 'Usuario Creado Correctamente');
            Get.to(const Login());
          } else {
            Get.snackbar('Error', 'Ocurrió un error durante la creación');
          }
        }
      } on Exception catch (e) {
        print(e.toString());
        Get.snackbar('Error', 'Credenciales incorrectas');
      }
    } else {
      return Get.snackbar("Error", "Ingrese todos los campos primero");
    }
  }
}
