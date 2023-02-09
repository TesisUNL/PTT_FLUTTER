import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';
import 'package:ptt_rtmb/core/models/attraction/attraction_marker.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/htppWrapper.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/httpHelper.service.dart';
import 'dart:async';
import 'package:ptt_rtmb/enviroment.dart';

const String ATTRACTION_URL = '/attractions';
const int PAGE_SIZE = 10;

HttpWrapper http = HttpWrapper();

Future<List<Attraction>> getAttractions({int? page}) async {
  page ??= 0;
  Map<String, dynamic> queryParams = {
    "pagination": json.encode({"start": (page * PAGE_SIZE), "limit": PAGE_SIZE})
  };

  final response = await http.get(ATTRACTION_URL, queryParams: queryParams);

  if (!HttpHelperService.isSuccessfullyResponse(response!.statusCode)) {
    throw Exception('Failed to load attractions');
  }
  return Attraction.fromJsonList(jsonDecode(response.body));
}

Future<List<MarkerAttraction>> getMarkerAttractions() async {
  try {
    List<Attraction> attractions = await getAttractions();
    return MarkerAttraction.fromAttractionList(attractions);
  } on Exception catch (e) {
    throw Exception(e.toString());
  }
}

Future<List<Attraction>> getAttractionsByCantonName(String cantonName) async {
  final response = await http.get(ATTRACTION_URL + '/byCanton/' + cantonName);
  if (!HttpHelperService.isSuccessfullyResponse(response!.statusCode)) {
    throw Exception('Failed to load attractions');
  }
  return Attraction.fromJsonList(jsonDecode(response.body));
}
