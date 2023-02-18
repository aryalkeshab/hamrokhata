import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final String baseUrl;
  late Dio _dio;
  final Interceptor? interceptor;

  ApiClient({required this.baseUrl, required Dio dio, this.interceptor}) {
    _dio = dio;

    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 60000
      ..options.receiveTimeout = 60000
      ..httpClientAdapter
      ..options.headers = {'Accept': 'application/json'};

    if (interceptor != null) {
      _dio.interceptors.clear();
      _dio.interceptors.add(interceptor!);
    }
    _dio.interceptors.add(PrettyDioLogger(
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        requestBody: true));

    // handle certificate verification check (for http request)
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options ?? Options(headers: {"requiresToken": false}),
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> authGet(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options ?? Options(headers: {"requiresToken": true}),
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    // ignore: type_annotate_public_apis
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: {"requiresToken": false}),
      );
      print(response);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> authPost(
    String uri, {
    // ignore: type_annotate_public_apis
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: {"requiresToken": true}),
      );
      print(response);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> authPostWithFile(
    String uri, {
    // ignore: type_annotate_public_apis
    data,
    File? file,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        options: options ?? Options(headers: {"requiresToken": true}),
      );
      print(response);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> authPut(
    String uri, {
    // ignore: type_annotate_public_apis
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: {"requiresToken": true}),
      );
      print(response);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  ///ReCaptcha validated POST method
  Future<dynamic> validatedPost(
    String uri, {
    // ignore: type_annotate_public_apis
    data,
    String? token,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(headers: {
              "requiresToken": false,
              'Authorization': 'Bearer $token',
            }),
      );
      print(response);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  ///ReCaptcha validated PUT method
  Future<dynamic> validatedPut(
    String uri, {
    // ignore: type_annotate_public_apis
    data,
    String? token,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(headers: {
              "requiresToken": false,
              'Authorization': 'Bearer $token',
            }),
      );
      print(response);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String uri, {
    // ignore: type_annotate_public_apis
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: {"requiresToken": false}),
      );
      print(response);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
