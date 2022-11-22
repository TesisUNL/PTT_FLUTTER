import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  // ignore: non_constant_identifier_names
  static String _get_environment_value(String key, String? defaultValue) {
    return defaultValue != null
        ? dotenv.get(key)
        : dotenv.get(key, fallback: defaultValue);
  }

  static String get androidApiKey =>
      _get_environment_value('ANDROID_API_KEY', 'ANDROID_API_KEY not found');

  static String get androidAppId =>
      _get_environment_value('ANDROID_APP_ID', 'ANDROID_APP_ID not found');

  static String get messagingSenderId => _get_environment_value(
      'MESSAGING_SENDER_ID', 'MESSAGING_SENDER_ID not found');

  static String get projectId =>
      _get_environment_value('PROJECT_ID', 'PROJECT_ID not found');

  static String get storageBucket =>
      _get_environment_value('STORAGE_BUCKET', 'STORAGE_BUCKET not found');

  static String get iosApiKey =>
      _get_environment_value('IOS_API_KEY', 'IOS_API_KEY not found');

  static String get iosAppId =>
      _get_environment_value('IOS_APP_ID', 'IOS_APP_ID not found');

  static String get iosClientId =>
      _get_environment_value('IOS_CLIENT_ID', 'IOS_CLIENT_ID not found');

  static String get iosBundleId =>
      _get_environment_value('IOS_BUNDLE_ID', 'IOS_BUNDLE_ID not found');

  static String get api_host =>
      _get_environment_value('API_URL', 'HOST not found');

  static String get api_scheme => _get_environment_value('API_SCHEMA', 'http');

  static String get api_part => _get_environment_value('API_PART', '');
}
