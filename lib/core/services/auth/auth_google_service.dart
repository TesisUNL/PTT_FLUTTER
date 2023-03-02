import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ptt_rtmb/core/controlers/login_screen_controller.dart';
import 'package:ptt_rtmb/core/controlers/register_screen_controller.dart';
import 'package:ptt_rtmb/core/models/user/auth_user.dart';
import 'package:ptt_rtmb/core/models/user/user.dart' as UserModel;
import 'package:ptt_rtmb/features/layout/main_screen.dart';

class AuthClass {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;

  final storage = const FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        try {
          GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;

          AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken,
          );

          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          bool isNewUser = userCredential.additionalUserInfo!.isNewUser;
          String profileId = userCredential.additionalUserInfo!.profile!["id"];
          User user = userCredential.user!;

          if (isNewUser) {
            final registerController = Get.put(RegisterController());
            print('New User');
            registerController.email.value = user.email ?? "";
            registerController.password.value = profileId;
            registerController.name.value = user.displayName ?? "";
            registerController.phoneNumber.value =
                user.phoneNumber ?? "Not phone number found";
            registerController.authSocialToken.value = user.uid;
            registerController.imageUrl.value = user.photoURL ?? "";
            registerController.registerLogic();
          } else {
            final loginController = Get.put(LoginController());
            print('Not New User');
            loginController.email.value = user.email!;
            loginController.password.value = profileId;
            loginController.loginLogic();
          }
        } catch (e) {
          print(e.toString());
          Get.snackbar('Error', e.toString());
        }
      } else {
        Get.snackbar('Error', 'No se puede logear');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      await storage.delete(key: "token");
    }
  }
}
