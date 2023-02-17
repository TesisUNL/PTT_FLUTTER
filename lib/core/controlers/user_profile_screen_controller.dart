import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ptt_rtmb/core/models/routes/route.dart';
import 'package:ptt_rtmb/core/models/user/user.dart';
import 'package:ptt_rtmb/core/services/rotues/routes_service.dart';

class ProfileScreenController extends GetxController {
  static ProfileScreenController get find => Get.find();
  FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<User?> getUser() async {
    String userString = await _storage.read(key: 'user') ?? '';
    late User user;
    if (userString.isNotEmpty) {
      user = User.fromJson(jsonDecode(userString));
    }
    return user;
  }

  User? returnUser() {
    User? user;

    getUser().then((value) =>
        {print('el user:' + value!.toJson().toString()), user = value});

    return user;
  }

  returnUserRoutes() async {
    User? user = await getUser();

    Future<List<TouristRoute>> touristRoutes =
        getTouristRoutesByOwnerId(user!.id);

    return touristRoutes;
  }
}
