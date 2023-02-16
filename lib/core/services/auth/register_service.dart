import 'dart:convert';

import 'package:http/http.dart' as httpPackage;
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/httpHelper.service.dart';

import '../../models/user/user.dart';
import '../../utils/helpers/HttpHelpers/htppWrapper.dart';

HttpWrapper http = HttpWrapper();

Future<User> postRegister(
    String email, String password, String name, String phoneNumber) async {
  Map params = {
    "email": email,
    "password": password,
    "name": name,
    "phone_number": phoneNumber
  };
  final response = await http.post('/auth/register', body: json.encode(params));
  if (HttpHelperService.isClientErrorResponse(response.statusCode) ||
      HttpHelperService.isServerErrorResponse(response.statusCode)) {
    throw Exception('Failed to Register');
  }
  return User.fromJson(jsonDecode(response.body));
}
