import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:ptt_rtmb/core/services/auth/auth_google_service.dart'; 
import 'package:ptt_rtmb/features/login/login.dart';

AppBar buildAppBar(BuildContext context) {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  AuthClass authClass = AuthClass();
  //signout function
  signOut() async {
    await authClass.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  final icon = CupertinoIcons.square_arrow_right;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        onPressed:  () async { await signOut(); },
      ),
    ],
  );
}
