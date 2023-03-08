import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final FlutterSecureStorage storage;

  AuthInterceptor(this._dio, this.storage);
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (err.response?.statusCode == 401) {
      refreshAccessToken(err, handler);
    }
    return handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("here...");
    print(options.headers);

    if (options.headers['requiresToken'] == false) {
      return handler.next(options);
    } else {
      final accessToken = await storage.read(key: StorageConstants.accessToken);
      print(accessToken);
      if (accessToken == null) {
        logout();
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

  void logout() {
    // showErrorToast(
    //   "Token expired. Please login again",
    // );
    Get.find<AuthController>().logout();
    Get.key.currentState
        ?.popUntil((route) => route.settings.name == Routes.login);
  }

  void refreshAccessToken(DioError err, ErrorInterceptorHandler handler) async {
    final refreshToken = await storage.read(key: StorageConstants.refreshToken);
    if (refreshToken == null) {
      logout();
    } else {
      try {
        final response = await _dio.post(
          '/token/refresh/',
          data: {'refresh': refreshToken},
        );
        print(" refresh token ${response.statusCode}");

        final accessToken = response.data['access'];
        final refreshToken2 = response.data['refresh'];
        await storage.write(
            key: StorageConstants.accessToken, value: accessToken);
        await storage.write(
            key: StorageConstants.refreshToken, value: refreshToken2);

        //continue to the original request
        // _dio.interceptors.requestLock.lock();
        // _dio.interceptors.responseLock.lock();
      } catch (e) {
        // showErrorToast(
        //   "Refresh token expired. Please login again",
        // );
        logout();
      }
    }
  }
}
