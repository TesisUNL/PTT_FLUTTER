import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/SessionInterceptor.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/httpHelper.service.dart';
import 'package:http/http.dart';

class HttpWrapper {
  HttpHelperService helperService = HttpHelperService();
  Client client = InterceptedClient.build(interceptors: [
    SessionInterceptor(),
  ]);

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParams, bool withAccessToken = true}) async {
    Map<String, String> headers =
        await helperService.buildHeaders(withAccessToken: withAccessToken);

    final response = await client.get(
      helperService.buildUri(path, queryParameters: queryParams),
      headers: headers,
    );
    return response;
  }

  Future<dynamic> post(String path,
      {Object? body, Encoding? encoding, bool withAccessToken = true}) async {
    Map<String, String> headers =
        await helperService.buildHeaders(withAccessToken: withAccessToken);

    final response = await client.post(
      helperService.buildUri(path),
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return response;
  }

  Future<dynamic> put(String path,
      {Object? body, Encoding? encoding, bool withAccessToken = true}) async {
    Map<String, String> headers =
        await helperService.buildHeaders(withAccessToken: withAccessToken);

    final response = await client.put(
      helperService.buildUri(path),
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return response;
  }

  Future<dynamic> delete(String path,
      {Object? body, Encoding? encoding, bool withAccessToken = true}) async {
    Map<String, String> headers =
        await helperService.buildHeaders(withAccessToken: withAccessToken);

    final response = await client.delete(
      helperService.buildUri(path),
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return response;
  }

  Future<dynamic> patch(String path,
      {Object? body, Encoding? encoding, bool withAccessToken = true}) async {
    Map<String, String> headers =
        await helperService.buildHeaders(withAccessToken: withAccessToken);

    final response = await client.patch(
      helperService.buildUri(path),
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return response;
  }
}
