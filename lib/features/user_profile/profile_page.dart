import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ptt_rtmb/core/models/user/user.dart';
import 'package:ptt_rtmb/core/utils/widgets/user_profile_widgets/profile_widget.dart';
import 'package:ptt_rtmb/core/utils/widgets/user_profile_widgets/appbar_widget.dart';
import '../../core/models/routes/route.dart';
import '../../core/services/rotues/routes_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  FlutterSecureStorage _storage = FlutterSecureStorage();
  late Future<List<TouristRoute>> touristRoutes;
  Future<List<TouristRoute>> fetchRoutes(String ownerId) async =>
      await getTouristRoutesByOwnerId(ownerId);

  @override
  void initState() {
    super.initState();
    _storage.read(key: 'user').then(((value) {
      setState(() {
        user = User.fromJson(jsonDecode(value!));
      });
    }));
    touristRoutes = fetchRoutes(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
              imagePath: user.image,
              onClicked: () async {} //TODO: implement image picker,
              ),
          const SizedBox(height: 24),
          buildUserData(user),
          const SizedBox(height: 48),
          buildRoutesWidget(),
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
              physics: const NeverScrollableScrollPhysics(),
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
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
            border: Border.all(color: Colors.blue, width: 3)),
        child: ListTile(
          title: Text(routeName),
          subtitle: Text(pathLenght.toString() + 'km'),
          leading: const Icon(
            Icons.map_rounded,
            color: Colors.blue,
          ),
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              Text(views.toString()),
              const Icon(Icons.remove_red_eye_outlined, color: Colors.blue),
            ],
          ),
        ),
      );

  Widget buildUserData(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            user.phone,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildRoutesWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Rutas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Tus rutas son:',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
