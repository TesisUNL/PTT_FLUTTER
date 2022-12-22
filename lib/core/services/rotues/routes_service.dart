import 'dart:convert';
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/htppWrapper.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/httpHelper.service.dart';
import 'dart:async';
import '../../models/routes/route.dart';

const String ROUTES_URL = '/tourist-routes';
HttpWrapper http = HttpWrapper();

Future<List<TouristRoute>> getTouristRoutes() async {
  final response = await http.get(ROUTES_URL);
  if (!HttpHelperService.isSuccessfullyResponse(response!.statusCode)) {
    throw Exception('Failed to load routes');
  }
  return TouristRoute.fromJsonList(jsonDecode(response.body));
}
