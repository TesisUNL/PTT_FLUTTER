import 'dart:convert';

import 'package:ptt_rtmb/core/constants/constants.dart';
import 'package:ptt_rtmb/core/utils/helpers/HttpHelpers/helper.service.dart';
import 'package:ptt_rtmb/enviroment.dart';
import 'package:http/http.dart' as http;

class HttpWrapper {
  HelperService helperService = HelperService();

  Future<dynamic> getter(String path, {bool withAccessToken = true}) async {
    try {
      final response = await http.get(
        helperService.buildUri(path),
        headers: helperService.buildHeaders(withAccessToken: withAccessToken),
      );
      return response;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> post(String path,
      {Object? body, Encoding? encoding, bool withAccessToken = true}) async {
    try {
      final response = await http.post(
        helperService.buildUri(path),
        headers: helperService.buildHeaders(withAccessToken: withAccessToken),
        body: body,
        encoding: encoding,
      );
      return response;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> put(String path,
      {Object? body, Encoding? encoding, bool withAccessToken = true}) async {
    try {
      final response = await http.put(
        helperService.buildUri(path),
        headers: helperService.buildHeaders(withAccessToken: withAccessToken),
        body: body,
        encoding: encoding,
      );
      return response;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> delete(String path,
      {Object? body, Encoding? encoding, bool withAccessToken = true}) async {
    try {
      final response = await http.delete(
        helperService.buildUri(path),
        headers: helperService.buildHeaders(withAccessToken: withAccessToken),
        body: body,
        encoding: encoding,
      );
      return response;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
