import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hamrokhata/commons/api/config.dart';

class Api {
  Dio dio = Dio();

  void getClient() async {
    dio.options.baseUrl = Config.baseApiUrl;
    dio.options.headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer token ",
      // "Bearer " + SpUtil.getString(Constants.authToken),
    };
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}
