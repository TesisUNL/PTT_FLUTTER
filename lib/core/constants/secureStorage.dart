import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const String accessTokenKey = 'access_token';
  static const String userIdKey = 'user_id';
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}

// TODO: Implement this library (dont work ).
/* class StorageService {
  static StorageService? _storageUtil;
  static const String userKey = 'user';
  static late SharedPreferences storage;

  static Future<StorageService?> getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      StorageService secureStorage = StorageService._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  StorageService._();
  Future _init() async {
    storage = await SharedPreferences.getInstance();
  }

  static Future<bool> _writeData(String key, String value) async =>
      await storage.setString(key, value);

  static _readData(String key) async {
    storage.getString(key);
  }

  Future _deleteData(String key) async {
    await storage.remove(key);
  }

  static Future<AuthUser?> getAuthUser() async {
    var json = await _readData(userKey);
    print(json);
    if (json != null) {
      return AuthUser.fromJson(jsonDecode(json));
    }

    return null;
  }

  static Future<bool> setAccessToken(AuthUser authUser) async =>
      await _writeData('access_token', authUser.accessToken);
}
 */