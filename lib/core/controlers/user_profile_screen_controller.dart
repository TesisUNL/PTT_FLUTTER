import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ptt_rtmb/core/models/user/user.dart';

class ProfileScreenController extends GetxController {
  static ProfileScreenController get find => Get.find();
  FlutterSecureStorage _storage = FlutterSecureStorage();

  getUser() async {
    String userString = await _storage.read(key: 'user') ?? '';

    if (userString.isNotEmpty) {
      User user = User.fromJson(jsonDecode(userString));
      return user;
    }
  }

  loadRoutes() async {
    User user = await getUser();
    
    

  }

}
