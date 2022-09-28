import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as httpPackage;
import 'dart:async';
import 'package:ptt_rtmb/enviroment.dart';

import '../utils/helpers/HttpHelpers/htppWrapper.dart';

HttpWrapper http = HttpWrapper();

Future<httpPackage.Response> postRegister(
    String email, String password, String name) async {
  Map params = {"email": email, "password": password, "name": name};
  var response = await http.post('/auth/register', body: params);
  return response;
}

Future<httpPackage.Response> postLogin(String email, String password) async {
  Map params = {"email": email, "password": password};
  var response = await http.post('/auth/login', body: params);
  return response;
}
