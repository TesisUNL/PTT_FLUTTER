import 'dart:async';
import 'dart:convert';

import 'package:ptt_rtmb/core/models/user/auth_user.dart';
import '../../models/user/user.dart';
import '../../utils/helpers/HttpHelpers/htppWrapper.dart';
import '../../utils/helpers/HttpHelpers/httpHelper.service.dart';

HttpWrapper http = HttpWrapper();

Future<AuthUser?> postLogin(String email, String password) async {
  Map params = {"email": email, "password": password};
  final response =
      await http.post('/auth/login', body: params, withAccessToken: false);
  if (!HttpHelperService.isSuccessfullyResponse(response!.statusCode)) {
    throw Exception(response.body);
  }
  return AuthUser.fromJson(jsonDecode(response.body));
}
