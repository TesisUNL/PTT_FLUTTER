import 'dart:async';
import 'package:flutter/material.dart';

import 'create_route.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<RoutesPage> createState() => RoutesPageState();
}

class RoutesPageState extends State<RoutesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutas'),
      ),
      body: ListView(
        children: [
          for (var i = 0; i < 10; i++)
            buildRoutesContainer('Nombre de ruta', 12000, 4),
        ],
      ),
      persistentFooterButtons: <Widget>[
        Text('Crea tu propia ruta:    '),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateRoutePage()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

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
}
