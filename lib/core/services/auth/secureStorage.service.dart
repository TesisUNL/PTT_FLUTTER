import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/user/auth_user.dart';

class SecureStorageService {
  static const storage = FlutterSecureStorage();

  static const String userKey = 'user';

  Future _writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future _readSecureData(String key) async {
    await storage.read(key: key);
  }

  Future _deleteSecureData(String key) async {
    await storage.delete(key: key);
  }

  Future _deleteAllSecureData() async {
    await storage.deleteAll();
  }

  Future _readAllSecureData() async {
    await storage.readAll();
  }

  Future<AuthUser?> getAuthUser() async {
    final json = await _readSecureData(userKey);
    if (json != null) {
      return AuthUser.fromJson(jsonDecode(json));
    }
    return null;
  }

  Future<void> setUser(AuthUser authUser) async {
    await _writeSecureData(userKey, jsonEncode(authUser.toJson()));
  }
}
