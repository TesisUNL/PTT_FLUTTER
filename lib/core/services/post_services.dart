import 'package:http/http.dart' as http;
import 'dart:async';

String host = '192.168.0.9:3000';

Future<http.Response> postRegister(String email, String password) async {
  Map params = {"email": email, "password": password};
  var response =
      await http.post(Uri.http(host, '/auth/register'), body: params);
  return response;
}

Future<http.Response> postLogin(String email, String password) async {
  Map params = {"email": email, "password": password};
  var response = await http.post(Uri.http(host, '/auth/login'), body: params);
  return response;
}


