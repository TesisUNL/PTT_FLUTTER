import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';
import 'package:ptt_rtmb/core/services/attraction/attraction_service.dart';
import 'package:ptt_rtmb/core/utils/helpers/places.dart';
import 'package:ptt_rtmb/core/utils/widgets/horizontal_place_item.dart';
import 'package:ptt_rtmb/core/utils/widgets/icon_badge.dart';
import 'package:ptt_rtmb/core/utils/widgets/search_bar.dart';
import 'package:ptt_rtmb/core/utils/widgets/vertical_place_item.dart';
import 'package:permission_handler/permission_handler.dart';

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildButtonRequestPermissionCamera(
                            Permission.camera, context),
                        _buildButtonRequestPermissionContacts(
                            Permission.contacts, context),
                        _buildButtonRequestPermissionLocation(
                            Permission.locationWhenInUse, context)
                      ],
                    ),
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
          itemCount: 5,
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

  Widget _buildButtonRequestPermissionContacts(
      Permission permission, BuildContext context) {
    return _buildButton(Colors.yellow[300]!, 'Solicitud permiso contactos',
        permission, context);
  }

  Widget _buildButtonRequestPermissionLocation(
      Permission permission, BuildContext context) {
    return _buildButton(Colors.green[300]!, 'Solicitud permiso localización',
        permission, context);
  }

  Widget _buildButtonRequestPermissionCamera(
      Permission permission, BuildContext context) {
    return _buildButton(
        Colors.blue[300]!, 'Solicitud permiso camara', permission, context);
  }

  Widget _buildButton(
      Color color, String title, Permission permission, BuildContext context) {
    return MaterialButton(
      minWidth: 250,
      color: color,
      child: Text(title),
      onPressed: () {
        _requestPermission(permission, context);
      },
    );
  }

  void _requestPermission(Permission permission, BuildContext context) async {
    if (await permission.request().isGranted) {
      //Permiso concedido
      _displaySnackBar(context);
    } else if (await permission.request().isDenied) {
      //Permiso revocado
      _displaySnackBarNeedPermission(context);
    } else {
      //Preguntamos si está permanentemente denegado
      requestPermanentlyDeniedPermission(permission);
    }
  }

  void _displaySnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("'Permisos concedidos"),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  void _displaySnackBarNeedPermission(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "'Necesitamos esos permisos para que la app funcione de forma correcta"),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  void requestPermanentlyDeniedPermission(Permission permission) async {
    if (await permission.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void requestMultiplesPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.manageExternalStorage
    ].request();
    print(statuses[Permission.location]);
  }
}
