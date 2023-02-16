import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/models/request/change_password_params.dart';
import 'package:hamrokhata/models/request/forget_password.dart';
import 'package:hamrokhata/models/request/login_params.dart';
import 'package:hamrokhata/models/request/otp_params.dart';
import 'package:hamrokhata/models/request/register_params.dart';
import 'package:hamrokhata/models/request/reset_password_params.dart';

abstract class AuthLoginRegisterRepositoryRemoteDataSource {
  Future<dynamic> loginAuth(LoginParams loginParams);

  Future<dynamic> registerAuth(RegisterParams registerParams);
  Future<dynamic> otpAuth(OtpParams otpParams);
  Future<dynamic> changePasswordAuth(ChangePasswordParams changePasswordParams);
  Future<dynamic> forgetPasswordAuth(ForgetPasswordParams forgetPasswordParams);
  Future<dynamic> passwordResetAuth(ResetPasswordParams resetPasswordParams);
}

class AuthLoginRegisterRepositoryRemoteDataSourceImpl
    extends AuthLoginRegisterRepositoryRemoteDataSource {
  final ApiClient apiClient;
  AuthLoginRegisterRepositoryRemoteDataSourceImpl({required this.apiClient});

  @override
  loginAuth(LoginParams loginParams) {
    return apiClient.post(APIPathHelper.authAPIs(APIPath.login),
        data: loginParams.toJson());
  }

  @override
  registerAuth(RegisterParams registerParams) {
    return apiClient.post(APIPathHelper.authAPIs(APIPath.register),
        data: registerParams.toJson());
  }

  @override
  otpAuth(OtpParams otpParams) {
    return apiClient.post(APIPathHelper.authAPIs(APIPath.otpAuth),
        data: otpParams.toJson());
  }

  @override
  changePasswordAuth(ChangePasswordParams changePasswordParams) {
    return apiClient.authPost(
        APIPathHelper.authAPIs(
          APIPath.changePasswordAuth,
        ),
        data: changePasswordParams.toJson());
  }

  @override
  forgetPasswordAuth(ForgetPasswordParams forgetPasswordParams) {
    return apiClient.post(
        APIPathHelper.authAPIs(
          APIPath.forgetPasswordAuth,
        ),
        data: forgetPasswordParams.toJson());
  }

  @override
  passwordResetAuth(ResetPasswordParams resetPasswordParams) {
    return apiClient.post(
        APIPathHelper.authAPIs(
          APIPath.resetPassword,
          id: resetPasswordParams.user_id.toString(),
        ),
        data: resetPasswordParams.toJson());
  }
}
