import 'dart:convert';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ptt_rtmb/features/login/login.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';
  static Map user = Login.returnUser;

  static User myUser = User(
    image:
        user['photo'] ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/800px-User_icon_2.svg.png",
    name: user['name'] ?? 'User Name',
    email: user['email'] ?? 'placeholder@gmail.com',
    phone: user['phone'] ?? '(593) 939-577704',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
