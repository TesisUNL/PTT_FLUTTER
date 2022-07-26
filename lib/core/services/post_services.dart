import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:ptt_rtmb/enviroment.dart';

String host = Enviroment.host;

Future<http.Response> postRegister(
    String email, String password, String name) async {
  Map params = {"email": email, "password": password, "name": name};
  var response =
      await http.post(Uri.http(host, '/auth/register'), body: params);
  return response;
}

Future<http.Response> postLogin(String email, String password) async {
  Map params = {"email": email, "password": password};
  var response = await http.post(Uri.http(host, '/auth/login'), body: params);
  return response;
}
