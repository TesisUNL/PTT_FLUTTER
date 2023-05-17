import 'dart:convert';

import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/httpHelper.service.dart';

import '../../models/user/user.dart';
import '../../utils/helpers/HttpHelpers/htppWrapper.dart';

HttpWrapper http = HttpWrapper();

Future<User> getUserService(String userId) async {
  final response = await http.get('/users/$userId');
  if (HttpHelperService.isClientErrorResponse(response.statusCode) ||
      HttpHelperService.isServerErrorResponse(response.statusCode)) {
    throw Exception('Failed to get User');
  }
  return User.fromJson(jsonDecode(response.body));
}
