import 'dart:async';
import 'package:flutter/material.dart';

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
        Text('Crea tu propia ruta: '),
        ElevatedButton(
          onPressed: () {},
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListTile(
          title: Text(routeName),
          subtitle: Text(pathLenght.toString() + 'km'),
          leading: Icon(
            Icons.map_rounded,
            color: Colors.blue,
          ),
          trailing: Text(views.toString() + ' views'),
        ),
      );
}
