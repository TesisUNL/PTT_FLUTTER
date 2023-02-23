import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ptt_rtmb/features/layout/main_screen.dart';
import '../constants/secureStorage.dart';
import '../models/user/auth_user.dart';
import '../services/auth/auth_local_services.dart';

class LoginController extends GetxController {
  static LoginController get find => Get.find();
  RxString email = "".obs;
  RxString password = "".obs;
  RxBool isObscure = true.obs;
  FlutterSecureStorage _storage = FlutterSecureStorage();

  loginLogic() async {
    String userEmail = email.value;
    String userPassword = password.value;
    if (!GetUtils.isEmail(userEmail)) {
      return Get.snackbar("Error", "Ingrese un Email Válido");
    }
    if (userEmail.isNotEmpty && userPassword.isNotEmpty) {
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
        Get.snackbar('Error', 'Credenciales incorrectas');
      }
    }
  }
}
