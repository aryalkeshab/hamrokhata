import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_remote_data_source.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_repository.dart';
import 'package:hamrokhata/Screens/auth/login/login_controller.dart';
import 'package:hamrokhata/Screens/auth/register/register_controller.dart';
import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/network_info.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<AuthLoginRegisterRepositoryRemoteDataSource>(
          AuthLoginRegisterRepositoryRemoteDataSourceImpl(
              apiClient: Get.find<ApiClient>()),
          permanent: true)
      ..put<AuthLoginRegisterRepository>(
          AuthLoginRegisterRepositoryImpl(
            authLoginRegisterRepositoryRemoteDataSource:
                Get.find<AuthLoginRegisterRepositoryRemoteDataSource>(),
            networkInfo: Get.find<NetworkInfo>(),
            secureStorage: Get.find<FlutterSecureStorage>(),
          ),
          permanent: true)
      ..put(LoginController(), permanent: true)
      ..put(RegisterController(), permanent: true);
  }
}
