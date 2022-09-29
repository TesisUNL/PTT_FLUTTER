import 'package:ptt_rtmb/core/constants/constants.dart';
import 'package:ptt_rtmb/core/models/user/auth_user.dart';
import 'package:ptt_rtmb/core/services/auth/secureStorage.service.dart';
import 'package:ptt_rtmb/enviroment.dart';
import 'package:ptt_rtmb/features/login/login.dart';

SecureStorageService secureStorageService = SecureStorageService();

class HelperService {
  final String _host = Constants.api_url;
  final String _scheme = Constants.api_scheme;
  final String _apiPath = Constants.api_part;
  late String _accessToken;

  Uri buildUri(String path) {
    if (_scheme == 'http') {
      return Uri.http(_host, '$_apiPath$path');
    } else {
      return Uri.https(_host, '$_apiPath$path');
    }
  }

  Map<String, String> buildHeaders({bool? withAccessToken}) {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (withAccessToken == true) {
      secureStorageService.getAuthUser().then((AuthUser? user) {
        if (user != null) {
          _accessToken = user.accessToken;
          headers['Authorization'] = 'Bearer $_accessToken';
        }
      });
    }
    return headers;
  }
}
