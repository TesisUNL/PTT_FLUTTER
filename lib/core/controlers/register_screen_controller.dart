import 'package:get/get.dart';
import 'package:ptt_rtmb/features/authentication/login/login.dart';
import '../models/user/user.dart';
import '../services/auth/register_service.dart';

class RegisterController extends GetxController {
  static RegisterController get find => Get.find();

  RxString email = "".obs;
  RxString password = "".obs;
  RxString name = "".obs;
  RxString phoneNumber = "".obs;
  RxBool isObscure = true.obs;

  registerLogic() async {
    String userEmail = email.value;
    String userPassword = password.value;
    String userName = name.value;
    String userPhoneNumber = phoneNumber.value;

    if (!GetUtils.isEmail(userEmail)) {
      return Get.snackbar("Error", "Ingrese un Email Válido");
    }
    if (userEmail.isNotEmpty &&
        userPassword.isNotEmpty &&
        userName.isNotEmpty &&
        userPhoneNumber.isNotEmpty) {
      try {
        User? createdUser = await postRegister(
            userEmail, userPassword, userName, userPhoneNumber);
        if (createdUser != null) {
          Get.snackbar('Éxito', 'Usuario Creado Correctamente');
          Get.to(Login());
        }
      } on Exception catch (e) {
        print(e.toString());
        Get.snackbar('Error', 'Credenciales incorrectas');
      }
    }
  }
}
