import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ptt_rtmb/core/constants/constants.dart';
import 'package:ptt_rtmb/core/models/user/auth_user.dart';
import 'package:ptt_rtmb/core/constants/secureStorage.dart';
import 'package:ptt_rtmb/enviroment.dart';
import 'package:ptt_rtmb/features/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpHelperService {
  final String _host = Constants.api_url;
  final String _scheme = Constants.api_scheme;
  final String _apiPath = Constants.api_part;
  late String? _accessToken;
  FlutterSecureStorage _storage = FlutterSecureStorage();

  Uri buildUri(String path) {
    if (_scheme == 'http') {
      return Uri.http(_host, '$_apiPath$path');
    } else {
      return Uri.https(_host, '$_apiPath$path');
    }
  }

  Future<Map<String, String>> buildHeaders({bool? withAccessToken}) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      //"Content-Type": "application/json",
    };
    if (withAccessToken == true) {
      _accessToken = (await _storage.read(key: SecureStorage.accessTokenKey));
      if (_accessToken != null) {
        headers['Authorization'] = 'Bearer $_accessToken';
        return headers;
      }
    }

    return headers;
  }

  static isSuccessfullyResponse(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  static isRedirectResponse(int statusCode) {
    return statusCode >= 300 && statusCode < 400;
  }

  static isClientErrorResponse(int statusCode) {
    return statusCode >= 400 && statusCode < 500;
  }

  static isServerErrorResponse(int statusCode) {
    return statusCode >= 500;
  }
}
