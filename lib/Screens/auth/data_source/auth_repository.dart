import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_remote_data_source.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_remote_data_source.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/product_detail.dart';
import 'package:hamrokhata/models/request/change_password_params.dart';
import 'package:hamrokhata/models/request/forget_password.dart';
import 'package:hamrokhata/models/request/login_params.dart';
import 'package:hamrokhata/models/request/otp_params.dart';
import 'package:hamrokhata/models/request/register_params.dart';

abstract class AuthLoginRegisterRepository {
  Future<ApiResponse> loginAuth(LoginParams loginParams);
  Future<ApiResponse> registerAuth(RegisterParams registerParams);
  Future<ApiResponse> otpAuth(OtpParams otpParams);

  Future<ApiResponse> changePasswordAuth(
      ChangePasswordParams changePasswordParams);
  Future<ApiResponse> forgetPasswordAuth(
      ForgetPasswordParams forgetPasswordParams);
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
        print(result['msg']);
        await secureStorage.write(
            key: StorageConstants.refreshToken,
            value: result['token']['refresh']);
        await secureStorage.write(
            key: StorageConstants.loginStaff,
            value: result['user_id'].toString());
        await secureStorage.write(
            key: StorageConstants.accessToken,
            value: result["token"]["access"]);
        print("-----");
        print(secureStorage.read(key: StorageConstants.loginStaff));
        showSuccessToast(result['msg']);

        return ApiResponse(data: result['msg']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.response) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: e.response?.data['message']));
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
        // await secureStorage.write(
        //     key: StorageConstants.registeruserId,
        //     value: result['user_id'].toString());
        showSuccessToast(result['msg']);

        return ApiResponse(data: result['user_id']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.response) {
          return ApiResponse(
            error: NetworkException.defaultError(
              // value: e.response?.data['error'].toString(),
              value: "Email or Phone No. already exists",
            ),
          );
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> otpAuth(OtpParams otpParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authLoginRegisterRepositoryRemoteDataSource
            .otpAuth(otpParams);
        print(result);

        return ApiResponse(data: result[0]['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.response) {
          return ApiResponse(
            error: NetworkException.defaultError(
              // value: e.response?.data[0]['message'],
              value: "Something went wrong",
            ),
          );
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> changePasswordAuth(
      ChangePasswordParams changePassword) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authLoginRegisterRepositoryRemoteDataSource
            .changePasswordAuth(changePassword);
        print(result);

        return ApiResponse(data: result['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.response) {
          return ApiResponse(
            error: NetworkException.defaultError(
              // value: e.response?.data[0]['message'],
              value: "Something went wrong",
            ),
          );
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> forgetPasswordAuth(
      ForgetPasswordParams forgetPasswordParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authLoginRegisterRepositoryRemoteDataSource
            .forgetPasswordAuth(forgetPasswordParams);
        print(result);
        await secureStorage.write(
            key: StorageConstants.resetpassworduserId,
            value: result['user_id'].toString());

        // showSuccessToast(result['status']);

        return ApiResponse(data: result['user_id']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.response) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: "Email must not be empty"));
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
