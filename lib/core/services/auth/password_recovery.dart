import 'dart:async';
import 'dart:convert';
import 'package:ptt_rtmb/core/models/user/auth_user.dart';
import '../../utils/helpers/HttpHelpers/htppWrapper.dart';
import '../../utils/helpers/HttpHelpers/httpHelper.service.dart';

HttpWrapper http = HttpWrapper();

Future postForgotPassword(String email) async {
  Map<String, String> params = {"email": email};
  final response = await http.post('/auth/forgotPassword',
      body: json.encode(params), withAccessToken: false);
  if (!HttpHelperService.isSuccessfullyResponse(response!.statusCode)) {
    throw Exception(response.body);
  }
  return jsonDecode(response.body);
}
