import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/services/rotues/routes_service.dart';
import 'package:ptt_rtmb/core/utils/widgets/AppLoading.dart';

import '../../core/models/routes/route.dart';
import 'create_route.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<RoutesPage> createState() => RoutesPageState();
}

class RoutesPageState extends State<RoutesPage> {
  late Future<List<TouristRoute>> touristRoutes;
  Future<List<TouristRoute>> fetchRoutes() async => await getTouristRoutes();

  @override
  void initState() {
    super.initState();
    touristRoutes = fetchRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutas'),
      ),
      body: FutureBuilder<List<TouristRoute>>(
        future: touristRoutes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
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
          return const AppLoading();
        },
      ),
      persistentFooterButtons: <Widget>[
        const Text('Crea tu propia ruta:    '),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateRoutePage()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

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
          subtitle: Text('${pathLenght}km'),
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
}
