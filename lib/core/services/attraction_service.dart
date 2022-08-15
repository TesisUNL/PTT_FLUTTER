import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';
import 'dart:async';
import 'package:ptt_rtmb/enviroment.dart';

const String ATTRACTION_URL = '/attractions';
String host = Enviroment.host;

Future<List<Attraction>> getAttractions() async {
  final response = await http.get(Uri.http(host, ATTRACTION_URL));

  if (response.statusCode == 200) {
    return Attraction.fromJsonList(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load attractions');
  }
}
