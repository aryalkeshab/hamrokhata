import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_remote_data_source.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_remote_data_source.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/models/product_detail.dart';
import 'package:hamrokhata/models/request/login_params.dart';
import 'package:hamrokhata/models/request/register_params.dart';

abstract class AuthLoginRegisterRepository {
  Future<ApiResponse> loginAuth(LoginParams loginParams);
  Future<ApiResponse> registerAuth(RegisterParams registerParams);
}

class AuthLoginRegisterRepositoryImpl extends AuthLoginRegisterRepository {
  final NetworkInfo networkInfo;
  final AuthLoginRegisterRepositoryRemoteDataSource
      authLoginRegisterRepositoryRemoteDataSource;
  final FlutterSecureStorage secureStorage;

  AuthLoginRegisterRepositoryImpl(
      {required this.networkInfo,
      required this.authLoginRegisterRepositoryRemoteDataSource,
      required this.secureStorage});

  @override
  Future<ApiResponse> loginAuth(LoginParams loginParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authLoginRegisterRepositoryRemoteDataSource
            .loginAuth(loginParams);
        await secureStorage.write(
            key: StorageConstants.accessToken, value: result[0]['token']);
        await secureStorage.write(
            key: StorageConstants.loginStaff, value: result[0]['user_id']);
        await secureStorage.write(
            key: StorageConstants.refreshToken,
            value: result[0]['refresh_token']);

        return ApiResponse(data: result[0]['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.response) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: e.response?.data[0]['message']));
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> registerAuth(RegisterParams registerParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authLoginRegisterRepositoryRemoteDataSource
            .registerAuth(registerParams);
        print(result);

        return ApiResponse(data: result[0]['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.response) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: e.response?.data[0]['message']));
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
