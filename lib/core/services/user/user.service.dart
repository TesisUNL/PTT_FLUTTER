import 'dart:convert';

import '../../models/user/user.dart';
import '../../utils/helpers/HttpHelpers/htppWrapper.dart';

HttpWrapper http = HttpWrapper();

Future<User> postRegister(String email, String password, String name) async {
  Map params = {"email": email, "password": password, "name": name};
  final response = await http.post('/auth/register', body: params);
  return User.fromJson(jsonDecode(response.body));
}
