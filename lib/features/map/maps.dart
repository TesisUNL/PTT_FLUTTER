import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  MapType _defaultMapType = MapType.normal;

  final Set<Marker> _markers = Set();

  final double _zoom = 19.151926040649414;

  CameraPosition _initialPosition = CameraPosition(
      target: LatLng(-4.090164444089922, -80.14413230944821), zoom: 14.4746);

  Completer<GoogleMapController> _controller = Completer();

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _goToParkMilagros() async {
    double lat = -4.108324397347485;
    double long = -80.15265016889954;
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('Parque Central Milagros'),
          position: LatLng(lat, long),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: _defaultMapType,
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: _initialPosition,
        ),
        Container(
          margin: EdgeInsets.only(top: 80, right: 10),
          alignment: Alignment.topRight,
          child: Column(children: <Widget>[
            FloatingActionButton(
                child: Icon(Icons.layers),
                elevation: 5,
                backgroundColor: Colors.teal[200],
                onPressed: () {
                  _changeMapType();
                  print('Changing the Map Type');
                }),
            SizedBox(
              height: 15,
            ),
            FloatingActionButton(
              child: Icon(Icons.directions_car),
              onPressed: _goToParkMilagros,
            )
          ]),
        ),
      ]),
    );
  }
}
