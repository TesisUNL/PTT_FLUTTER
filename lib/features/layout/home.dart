import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';
import 'package:ptt_rtmb/core/services/attraction/attraction_service.dart';
import 'package:ptt_rtmb/core/utils/widgets/horizontal_place_item.dart';
import 'package:ptt_rtmb/core/utils/widgets/search_bar.dart';
import 'package:ptt_rtmb/core/utils/widgets/vertical_place_item.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Attraction>> attractions;
  List<Attraction> _attractions = [];
  bool _isLoading = false;
  bool _isEndPagination = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _addAttractions(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  Future<Timer> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    const duration = Duration(seconds: 1);
    return Timer(duration, _responseHTTP);
  }

  void _responseHTTP() async {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.pixels + 100,
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn);
    }

    _addAttractions(_page);
  }

  void _addAttractions(int page) async {
    if (_isEndPagination) {
      setState(() {
        _isLoading = false;
        return;
      });
    }
    List<Attraction> pageAttractions = await getAttractions(page: page);
    _isLoading = false;
    if (pageAttractions.length == 0) {
      _isEndPagination = true;
      setState(() {});
      return;
    }
    _attractions.addAll(pageAttractions);
    setState(() {
      _page++;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_scrollController.hasClients) {
      _scrollController.dispose();
    }
  }

  Future _getPage1() async {
    const duration = Duration(milliseconds: 500);
    Timer(duration, () {
      _isEndPagination = false;
      _attractions.clear();
      _page = 0;
      _addAttractions(_page);
    });

    return Future.delayed(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_attractions.length > 0)
            ? RefreshIndicator(
                onRefresh: _getPage1,
                child: ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    const Padding(
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
                      padding: const EdgeInsets.all(20.0),
                      child: SearchBar(),
                    ),
                    buildHorizontalList(context, _attractions),
                    buildVerticalList(_attractions),
                    createLoading(),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }

  buildHorizontalList(BuildContext context, List<Attraction>? data) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 20.0),
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
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
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

  Widget createLoading() {
    if (_isEndPagination) {
      return Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: const Center(
          child: Text(
            "No hay más atracciones",
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
          const SizedBox(
            height: 12.0,
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
