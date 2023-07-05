import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/constants/constants.dart';
import 'package:ptt_rtmb/core/utils/widgets/horizontal_place_item.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/models/canton/canton.dart';
import '../../core/services/canton/canton_service.dart';
import '../../core/utils/widgets/AppLoading.dart';
import '../../core/utils/widgets/user_profile_widgets/appbar_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final ScrollController _scrollController = ScrollController();
  // late Future<List<Canton>> attractions;
  // final List<Attraction> _attractions = [];
  late Future<List<Canton>> cantons;
  Future<List<Canton>> fetchCantons() async => await getCantons();
  // bool _isLoading = false;
  // bool _isEndPagination = false;
  // int _page = 0;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    cantons = fetchCantons();
    // _addAttractions(_page);

    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     _fetchData();
    //   }
    // });
  }

  // Future<Timer> _fetchData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   const duration = Duration(seconds: 1);
  //   return Timer(duration, _responseHTTP);
  // }

  // void _responseHTTP() async {
  //   if (_scrollController.hasClients) {
  //     _scrollController.animateTo(_scrollController.position.pixels + 100,
  //         duration: const Duration(milliseconds: 250),
  //         curve: Curves.fastOutSlowIn);
  //   }

  //   _addAttractions(_page);
  // }

  // void _addAttractions(int page) async {
  //   if (_isEndPagination) {
  //     setState(() {
  //       _isLoading = false;
  //       return;
  //     });
  //   }
  //   List<Attraction> pageAttractions = await getAttractions(page: page);
  //   _isLoading = false;
  //   if (pageAttractions.isEmpty) {
  //     _isEndPagination = true;
  //     setState(() {});
  //     return;
  //   }
  //   _attractions.addAll(pageAttractions);
  //   setState(() {
  //     _page++;
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    // if (_scrollController.hasClients) {
    //   _scrollController.dispose();
    // }
  }

  // Future _getPage1() async {
  //   const duration = Duration(milliseconds: 500);
  //   Timer(duration, () {
  //     _isEndPagination = false;
  //     _attractions.clear();
  //     _page = 0;
  //     _addAttractions(_page);
  //   });

  //   return Future.delayed(duration);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Canton>>(
          future: cantons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildHorizontalList(context, snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(
              child: AppLoading(),
            );
          }),
    );
  }

  buildHorizontalList(BuildContext context, List<Canton>? data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 60),
        Text(Constants.appName,
            style: Theme.of(context).textTheme.headlineMedium),
        Container(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
          height: MediaQuery.of(context).size.height * 0.70,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              shrinkWrap: true,
              itemCount: data?.length,
              itemBuilder: (BuildContext context, int index) {
                Canton place = data![index];
                return HorizontalPlaceItem(canton: place);
              }),
        )
      ],
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

  // Widget createLoading() {
  //   if (_isEndPagination) {
  //     return Container(
  //       padding: const EdgeInsets.only(bottom: 10.0),
  //       child: const Center(
  //         child: Text(
  //           "No hay más atracciones",
  //           style: TextStyle(
  //             fontSize: 10.0,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   if (_isLoading) {
  //     return const Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             CircularProgressIndicator(),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 12.0,
  //         )
  //       ],
  //     );
  //   } else {
  //     return Container();
  //   }
  // }
}
