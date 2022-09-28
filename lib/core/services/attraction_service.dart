import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';
import 'package:ptt_rtmb/core/models/attraction/attraction_marker.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/htppWrapper.dart';
import 'dart:async';
import 'package:ptt_rtmb/enviroment.dart';

const String ATTRACTION_URL = '/attractions';
HttpWrapper http = HttpWrapper();

Future<List<Attraction>> getAttractions() async {
  try {
    final response = await http.getter(ATTRACTION_URL);
    return Attraction.fromJsonList(jsonDecode(response.body));
  } on Exception catch (e) {
    throw Exception(e.toString());
  }
}

Future<List<MarkerAttraction>> getMarkerAttractions() async {
  try {
    List<Attraction> attractions = await getAttractions();
    return MarkerAttraction.fromAttractionList(attractions);
  } on Exception catch (e) {
    throw Exception(e.toString());
  }
}
