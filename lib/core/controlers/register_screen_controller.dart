import 'package:get/get.dart';
import 'package:ptt_rtmb/core/controlers/login_screen_controller.dart';
import 'package:ptt_rtmb/features/authentication/login/login.dart';
import '../models/user/user.dart';
import '../services/auth/register_service.dart';

class RegisterController extends GetxController {
  static RegisterController get find => Get.find();

  RxString email = "".obs;
  RxString password = "".obs;
  RxString name = "".obs;
  RxString phoneNumber = "".obs;
  RxString authSocialToken = "".obs;
  RxBool isObscure = true.obs;

  registerLogic() async {
    String userEmail = email.value;
    String userPassword = password.value;
    String userName = name.value;
    String userPhoneNumber = phoneNumber.value;
    String userSocialToken = authSocialToken.value;

    if (!GetUtils.isEmail(userEmail)) {
      return Get.snackbar("Error", "Ingrese un Email Válido");
    }
    if (userEmail.isNotEmpty &&
        userPassword.isNotEmpty &&
        userName.isNotEmpty &&
        userPhoneNumber.isNotEmpty) {
      try {
        if (userSocialToken.isNotEmpty) {
          final loginController = Get.put(LoginController());
          User? createdUser = await postRegister(userEmail, userPassword,
              userName, userPhoneNumber, userSocialToken);
          if (createdUser != null) {
            Get.snackbar('Éxito', 'Usuario Creado Correctamente');
            loginController.email.value = userEmail;
            loginController.password.value = userPassword;
            await Future.delayed(const Duration(milliseconds: 500),
                () => loginController.loginLogic());
          }
        }
        User? createdUser = await postRegister(
            userEmail, userPassword, userName, userPhoneNumber);
        if (createdUser != null) {
          Get.snackbar('Éxito', 'Usuario Creado Correctamente');
          Get.to(const Login());
        }
      } on Exception catch (e) {
        print(e.toString());
        Get.snackbar('Error', 'Credenciales incorrectas');
      }
    }
  }
}
