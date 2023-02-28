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
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          bool isNewUser = userCredential.additionalUserInfo!.isNewUser;
          String profileId = userCredential.additionalUserInfo!.profile!["id"];
          User user = userCredential.user!;

          print(isNewUser);
          print(profileId);
          print(user);

          if (isNewUser) {
            final registerController = Get.put(RegisterController());
            registerController.email.value = user.email!;
            registerController.password.value = profileId;
            registerController.name.value = user.displayName!;
            registerController.phoneNumber.value = user.phoneNumber!;
            registerController.authSocialToken.value = user.uid;
            print('New User');
            await Future.delayed(const Duration(milliseconds: 500),
                () => registerController.registerLogic());
          } else {
            final loginController = Get.put(LoginController());
            loginController.email.value = user.email!;
            loginController.password.value = profileId;
            print('Not new user');
            await Future.delayed(const Duration(milliseconds: 500),
                () => loginController.loginLogic());
          }
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        final snackbar = SnackBar(content: Text("No se puede logear"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<AuthUser> ModelUser(User user) async {
    UserModel.User loggedUser = UserModel.User(
        id: user.providerData[0].uid ?? "",
        email: user.providerData[0].email ?? "",
        image: user.providerData[0].photoURL ??
            "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/800px-User_icon_2.svg.png",
        name: user.providerData[0].displayName ?? "User Name",
        phone: user.providerData[0].phoneNumber ?? "");

    AuthUser authUser = AuthUser(
      user: loggedUser,
      accessToken: '',
    );

    return authUser;
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      await storage.delete(key: "token");
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
