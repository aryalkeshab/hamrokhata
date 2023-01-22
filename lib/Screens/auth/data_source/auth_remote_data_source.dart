import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/models/request/login_params.dart';
import 'package:hamrokhata/models/request/register_params.dart';

abstract class AuthLoginRegisterRepositoryRemoteDataSource {
  Future<dynamic> loginAuth(LoginParams loginParams);

  Future<dynamic> registerAuth(RegisterParams registerParams);
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
}
