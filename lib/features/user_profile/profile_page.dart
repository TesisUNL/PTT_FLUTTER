import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/user/user.dart';
import 'package:ptt_rtmb/core/utils/widgets/user_profile_widgets/profile_widget.dart';
import 'package:ptt_rtmb/core/utils/widgets/user_profile_widgets/appbar_widget.dart';
import 'package:ptt_rtmb/features/login/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var user = Login.returnUser.user;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.image,
            onClicked: () async { } //TODO: implement image picker,
          ),
          const SizedBox(height: 24),
          buildUserData(user),
          const SizedBox(height: 48),
          buildRoutesWidget(user),
        ],
      ),
    );
  }

  Widget buildUserData(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            user.phone,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  //TODO AGREGAR WIDGET QUE CARGUE LAS RUTAS
  Widget buildRoutesWidget(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rutas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Tus rutas son:',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
