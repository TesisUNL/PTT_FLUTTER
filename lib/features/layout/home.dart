import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';
import 'package:ptt_rtmb/core/services/attraction/attraction_service.dart';
import 'package:ptt_rtmb/core/utils/widgets/horizontal_place_item.dart';
import 'package:ptt_rtmb/core/utils/widgets/icon_badge.dart';
import 'package:ptt_rtmb/core/utils/widgets/search_bar.dart';
import 'package:ptt_rtmb/core/utils/widgets/vertical_place_item.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Attraction>> attractions;
  Future<List<Attraction>> fetchAttractions() async => await getAttractions();

  @override
  void initState() {
    super.initState();
    attractions = fetchAttractions();
    _requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: IconBadge(
                icon: Icons.notifications_none,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: FutureBuilder<List<Attraction>>(
            future: attractions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "A dónde quieres \nir?",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SearchBar(),
                    ),
                    buildHorizontalList(context, snapshot.data),
                    buildVerticalList(snapshot.data),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  buildHorizontalList(BuildContext context, List<Attraction>? data) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          primary: false,
          itemCount: data?.length,
          itemBuilder: (BuildContext context, int index) {
            Attraction place = data!.reversed.toList()[index];
            return HorizontalPlaceItem(place: place);
          }),
    );
  }

  buildVerticalList(List<Attraction>? data) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          Attraction place = data![index];
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
      Permission.locationAlways,
      Permission.locationWhenInUse,
      Permission.storage,
    ].request();

    String successMessage = 'Se aceptó los siguientes permisos: ';
    String errorMessage = 'No se aceptaron los siguientes permisos: ';

    if (statuses[Permission.camera] == PermissionStatus.granted) {
      successMessage += 'Cámara, ';
    } else {
      errorMessage += 'Cámara, ';
    }

    if (statuses[Permission.location] == PermissionStatus.granted ||
        statuses[Permission.locationAlways] == PermissionStatus.granted ||
        statuses[Permission.locationWhenInUse] == PermissionStatus.granted) {
      successMessage += 'Localización, ';
    } else {
      errorMessage += 'Localización, ';
    }

    if (statuses[Permission.storage] == PermissionStatus.granted) {
      successMessage += 'Almacenamiento.';
    } else {
      errorMessage += 'Almacenamiento.';
    }

    print(errorMessage);
    print(successMessage);

    Future.delayed(const Duration(milliseconds: 200), () {
      if (errorMessage.contains('Cámara') ||
          errorMessage.contains('Localización') ||
          errorMessage.contains('Almacenamiento')) {
        _showAlertDialog();
      } else {
        return;
      }
    });
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: const Text("No aceptaste los permisos"),
            content: const Text(
                "Necesitamos que aceptes los permisos para funcionar bien"),
            actions: <Widget>[
              ElevatedButton(
                child: const Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text(
                  "DAR PERMISOS",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  openAppSettings();
                },
              )
            ],
          );
        });
  }
}
