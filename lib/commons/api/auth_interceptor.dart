import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final FlutterSecureStorage storage;

  AuthInterceptor(this._dio, this.storage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("here...");
    if (options.headers['requiresToken'] == false) {
      return handler.next(options);
    } else {
      final accessToken = await storage.read(key: StorageConstants.accessToken);
      print(accessToken);
      if (accessToken == null) {
        //TODO: perform logout , return to sign in page

        final error =
            DioError(requestOptions: options, type: DioErrorType.other);
        return handler.reject(error);
      } else {
        options.headers.addAll(
          <String, String>{'Authorization': 'Bearer $accessToken'},
        );
        return handler.next(options);
      }
    }
  }
}
