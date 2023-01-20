import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/user/user.dart';
import 'package:ptt_rtmb/core/utils/widgets/user_profile_widgets/profile_widget.dart';
import 'package:ptt_rtmb/core/utils/widgets/user_profile_widgets/appbar_widget.dart';
import 'package:ptt_rtmb/features/authentication/login/login.dart';

import '../../core/models/routes/route.dart';
import '../../core/services/rotues/routes_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  late Future<List<TouristRoute>> touristRoutes;
  Future<List<TouristRoute>> fetchRoutes(String ownerId) async =>
      await getTouristRoutesByOwnerId(ownerId);

  @override
  void initState() {
    super.initState();
    //user = Login.returnUser.user;
    touristRoutes = fetchRoutes(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
              imagePath: user.image,
              onClicked: () async {} //TODO: implement image picker,
              ),
          const SizedBox(height: 24),
          buildUserData(user),
          const SizedBox(height: 48),
          buildRoutesWidget(user),
          const SizedBox(height: 24),
          buildTouristRoutesList(),
        ],
      ),
    );
  }

  Widget buildTouristRoutesList() => FutureBuilder<List<TouristRoute>>(
        future: touristRoutes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return buildRoutesContainer(
                    snapshot.data![index].name,
                    snapshot.data![index].pathLength,
                    snapshot.data![index].views);
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      );

  Widget buildRoutesContainer(String routeName, int pathLenght, int views) =>
      Container(
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
            border: Border.all(color: Colors.blue, width: 3)),
        child: ListTile(
          title: Text(routeName),
          subtitle: Text(pathLenght.toString() + 'km'),
          leading: Icon(
            Icons.map_rounded,
            color: Colors.blue,
          ),
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              Text(views.toString()),
              Icon(Icons.remove_red_eye_outlined, color: Colors.blue),
            ],
          ),
        ),
      );

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
