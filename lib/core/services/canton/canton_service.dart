import 'dart:convert';
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/htppWrapper.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/httpHelper.service.dart';
import 'dart:async';
import '../../models/canton/canton.dart';

const String CANTONS_URL = '/cantons';
HttpWrapper http = HttpWrapper();

Future<List<Canton>> getCantons() async {
  final response = await http.get(CANTONS_URL);
  if (!HttpHelperService.isSuccessfullyResponse(response!.statusCode)) {
    throw Exception('Failed to load cantons');
  }
  return Canton.fromJsonList(jsonDecode(response.body));
}
