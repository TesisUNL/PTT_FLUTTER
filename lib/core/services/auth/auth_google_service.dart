import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  late User user;

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

          storeTokenAndData(userCredential);

          user = userCredential.user!;

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => MainScreen()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        final snackbar = SnackBar(content: Text("Not Able to sign In "));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await storage.write(
        key: "token", value: userCredential.credential?.token.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<AuthUser> UserSingIn() async {
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
