import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ptt_rtmb/core/models/routes/route.dart';
import 'package:ptt_rtmb/core/models/user/user.dart';
import 'package:ptt_rtmb/core/services/rotues/routes_service.dart';

import '../services/user/get_user_service.dart';

class ProfileScreenController extends GetxController {
  static ProfileScreenController get find => Get.find();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<User> getUser() async {
    String userId = await _storage.read(key: 'user_id') ?? '';

    return await getUserService(userId);
  }

  Future<List<TouristRoute>> returnUserRoutes() async {
    User? user = await getUser();
    Future<List<TouristRoute>> touristRoutes =
        getTouristRoutesByOwnerId(user.id);

    return touristRoutes;
  }
}
