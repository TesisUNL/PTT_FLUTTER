import 'package:http_interceptor/http_interceptor.dart';
import 'package:ptt_rtmb/core/services/navigator/navigatorService.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/httpHelper.service.dart';

class SessionInterceptor implements InterceptorContract {
  final Navigator = NavigatorService();
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {
      HttpHelperService.deleteSession();
      Navigator.navigateToLogin();
    }

    return data;
  }
}
