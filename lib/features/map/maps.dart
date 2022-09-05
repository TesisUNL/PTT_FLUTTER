import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ptt_rtmb/core/services/attraction_service.dart';
import '../../core/models/attraction/attraction_marker.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  late List<MarkerAttraction> fetchListMarkers;
  // TYpe Map
  MapType _defaultMapType = MapType.normal;

  List<Marker> allMarkers = [];

  // FETCH DATA
  late Future<List<MarkerAttraction>> markerAttraction;
  Future<List<MarkerAttraction>> fetchMarkers() async =>
      await getMarkerAttractions();

  late PageController _pageController;
  int prevPage = 0;

  final double _zoom = 19.151926040649414;

  //Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController _controller;

  Set<Polyline> polyline = Set<Polyline>();

  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
    markerAttraction = fetchMarkers();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  _elementList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            //moveCamera();// moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).dialogBackgroundColor),
                        child: Row(children: [
                          Container(
                              height: 450.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          fetchListMarkers[index].thumbNail),
                                      //'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                  fetchListMarkers[index].name,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  fetchListMarkers[index].address,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    fetchListMarkers[index].description,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ]))
                        ]))))
          ])),
    );
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  //void _onMapCreated(GoogleMapController controller) {
  //  _controller.complete(controller);
  //}

  //_goToParkMilagros() {
  //  double lat = -4.108324397347485;
  //  double long = -80.15265016889954;
  //  //GoogleMapController controller = await _controller.future;
  //  _controller
  //      .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
  //  setState(() {
  //    allMarkers.clear();
  //    allMarkers.add(
  //      Marker(
  //          markerId: MarkerId('Parque Central Milagros'),
  //          position: LatLng(lat, long),
  //          draggable: false,
  //          infoWindow: InfoWindow(
  //              title: 'Parque Central Milagros',
  //              snippet: 'Bienvenido al Parque')),
  //    );
  //  });
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mapa'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: markerAttraction,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                fetchListMarkers = snapshot.data as List<MarkerAttraction>;
                fetchListMarkers.forEach((MarkerAttraction attractionElement) {
                  allMarkers.add(Marker(
                      markerId: MarkerId(attractionElement.name),
                      infoWindow: InfoWindow(
                          title: attractionElement.name,
                          snippet: attractionElement.address),
                      draggable: false,
                      position: attractionElement.locationCoords));
                });

                return Stack(children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                        markers: Set.from(allMarkers),
                        mapType: _defaultMapType,
                        myLocationEnabled: true,
                        compassEnabled: true,
                        onMapCreated: mapCreated,
                        //indoorViewEnabled: true,
                        //trafficEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: fetchListMarkers[1].locationCoords,
                            zoom: 12.0)),
                  ),
                  Positioned(
                    top: 20,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: fetchListMarkers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _elementList(index);
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 180, right: 10),
                    alignment: Alignment.bottomRight,
                    child: Column(children: <Widget>[
                      FloatingActionButton(
                          child: Icon(Icons.layers),
                          elevation: 5,
                          backgroundColor: Theme.of(context).backgroundColor,
                          onPressed: () {
                            _changeMapType();
                            print('Changing the Map Type');
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      // FloatingActionButton(
                      //   child: Icon(Icons.directions_car),
                      //   onPressed: _goToParkMilagros,
                      // )
                    ]),
                  ),
                ]);
              }
              return CircularProgressIndicator();
            }));
  }

  void mapCreated(GoogleMapController controller) {
    // _controller.complete(controller);
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    //final GoogleMapController controller = await _controller.future;
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: fetchListMarkers[_pageController.page!.toInt()]
            .locationCoords, //.locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      moveCamera();
    }
  }
}
