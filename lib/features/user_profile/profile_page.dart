import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ptt_rtmb/features/login/login.dart';
import 'package:ptt_rtmb/features/user_profile/edit_image.dart';
import 'package:ptt_rtmb/features/user_profile/edit_name.dart';
import 'package:ptt_rtmb/features/user_profile/edit_phone.dart';
import 'package:ptt_rtmb/features/user_profile/edit_email.dart';
import 'package:ptt_rtmb/core/utils/widgets/user_profile_widgets/display_image_widget.dart';
import 'package:ptt_rtmb/core/models/user/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:ptt_rtmb/core/services/auth_service.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  AuthClass authClass = AuthClass();
  //signout function
  signOut() async {
    await authClass.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;

    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          Center(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Perfil',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(64, 105, 225, 1),
                    ),
                  ))),
          InkWell(
              onTap: () {
                navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: user.image,
                onPressed: () {},
              )),
          buildUserInfoDisplay(user.name, 'Nombre', EditNameFormPage()),
          buildUserInfoDisplay(user.phone, 'Teléfono', EditPhoneFormPage()),
          buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
          SizedBox(
            height: 80,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                signOut();
              },
              child: Icon(Icons.logout_rounded),
              backgroundColor: Color.fromRGBO(64, 105, 225, 1),
            ),
          )
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
