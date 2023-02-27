import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ptt_rtmb/core/constants/secureStorage.dart';
import 'package:ptt_rtmb/core/services/auth/auth_google_service.dart';
import 'package:ptt_rtmb/features/authentication/login/login.dart';

AppBar buildAppBar(BuildContext context) {
  AuthClass authClass = AuthClass();
  const storage = FlutterSecureStorage();

  signOut() async {
    await authClass.logout();
    await storage.delete(key: SecureStorage.userIdKey);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  const icon = CupertinoIcons.square_arrow_right;

  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: const Icon(icon),
        onPressed: () async {
          await signOut();
        },
      ),
    ],
  );
}
