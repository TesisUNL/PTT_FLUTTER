import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:ptt_rtmb/features/authentication/login/login.dart';
import 'package:ptt_rtmb/features/authentication/welcome/welcome.dart';
import 'package:ptt_rtmb/features/layout/main_screen.dart';
import '../constants/constants.dart';
import '../constants/image_strings.dart';
import '../constants/secureStorage.dart';
import '../constants/text_strings.dart';
import '../models/user/auth_user.dart';
import '../models/widgets/onboarding_widget_model.dart';
import '../services/auth/auth_local_services.dart';
import '../utils/widgets/onboarding_widget.dart';

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
          Get.to(MainScreen());
        }
      } on Exception catch (e) {
        print(e.toString());
        Get.snackbar('Error', 'Credenciales incorrectas');
      }
    }
  }
}
