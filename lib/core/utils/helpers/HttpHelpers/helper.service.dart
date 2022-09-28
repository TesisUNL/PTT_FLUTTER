import 'package:ptt_rtmb/core/constants/constants.dart';
import 'package:ptt_rtmb/enviroment.dart';

class HelperService {
  String _host = Constants.api_url;
  String _scheme = Constants.api_scheme;
  String _apiPath = Constants.api_part;

  Uri buildUri(String path) {
    if (_scheme == 'http') {
      return Uri.http(_host, '$_apiPath$path');
    } else {
      return Uri.https(_host, '$_apiPath$path');
    }
  }

  Map<String, String> buildHeaders({String? accessToken}) {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }
}
