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

Future<TouristRoute> postTouristRoute(
    String name, Set attractionsId, int pathLength) async {
  Map params = {
    "name": name,
    "attractions": attractionsId,
    "pathLength": pathLength = 0
  };
  final response = await http.post('/tourist-routes', body: params);
  if (HttpHelperService.isClientErrorResponse(response.statusCode) ||
      HttpHelperService.isServerErrorResponse(response.statusCode)) {
    throw Exception('Failed to Create a new Route');
  }

  return TouristRoute.fromJson(jsonDecode(response.body));
}
