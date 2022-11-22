import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptt_rtmb/core/constants/secureStorage.dart';
import 'package:ptt_rtmb/core/utils/helpers/rounded_btn.dart';
import 'package:ptt_rtmb/features/create_account/create_account.dart';
import 'package:ptt_rtmb/features/layout/main_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../core/models/user/auth_user.dart';
import '../../core/services/auth/auth_google_service.dart';
import '../../core/services/auth/auth_local_services.dart';

class Login extends StatefulWidget {
  static late AuthUser returnUser;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget currentPage = Login();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  bool showSpinner = false;
  late String email = '';
  late String password = '';
  AuthClass authClass = AuthClass();
  FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = MainScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xff251F34),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                      width: 175,
                      height: 175,
                      child: SvgPicture.asset('assets/login.svg')),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Ingrese sus credenciales para continuar.',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'E-mail',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          style: (TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xfff3B324E),
                            filled: true,
                            prefixIcon: Image.asset('assets/icon_email.png'),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff14DAE2), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) email = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Clave',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: (TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400)),
                        obscureText: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3B324E),
                          filled: true,
                          prefixIcon: Image.asset('assets/icon_lock.png'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff14DAE2), width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) password = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: RoundedButton(
                        btnText: 'INGRESAR',
                        color: Color(0xff14DAE2),
                        onPressed: _localLogin),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buttonItem(
                    context, "assets/google.svg", "Continuar con Google", 25,
                    () async {
                  await authClass.googleSignIn(context);
                  Login.returnUser = await authClass.UserSingIn();
                }),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    'Olvidó su clave?',
                    style: TextStyle(color: Color(0xff14DAE2)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No tiene cuenta?',
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccount()));
                      },
                      child: const Text('Registrarse',
                          style: TextStyle(
                            color: Color(0xff14DAE2),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonItem(BuildContext context, String imagePath, String buttonName,
      double size, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width - 60,
            height: 90,
            alignment: Alignment.center,
            child: Card(
              elevation: 8,
              color: Color.fromARGB(255, 75, 22, 88),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imagePath,
                    height: size,
                    width: size,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    buttonName,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _generateTextButton(BuildContext context, String buttonLabel) {
    return TextButton(
      child: Text(buttonLabel),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  void _generateDialog(BuildContext context,
      {required String title, required String content}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [_generateTextButton(context, 'Ok')],
        elevation: 24.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      barrierDismissible: false,
    );
  }

  Future _localLogin() async {
    if (email.isNotEmpty || password.isNotEmpty) {
      setState(() {
        showSpinner = true;
      });

      try {
        AuthUser? userLogged = await postLogin(email, password);
        if (userLogged != null) {
          setState(() {
            showSpinner = false;
          });
          await _storage.write(
              key: SecureStorage.accessTokenKey, value: userLogged.accessToken);
          Login.returnUser = userLogged;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        }
      } on Exception catch (e) {
        print(e.toString());
        setState(() {
          showSpinner = false;
        });

        _generateDialog(context,
            title: 'Error', content: 'Credenciales incorrectas');
      }
    }
  }
}
