import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/Screens/auth/auth_local_data_source.dart';
import 'package:hamrokhata/Screens/auth/auth_repository_impl.dart';
import 'package:hamrokhata/Screens/auth/login/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<AuthLocalDataSource>(
          AuthLocalDataSourceImpl(Get.find<FlutterSecureStorage>()),
          permanent: true)
      ..put<AuthRepository>(
          AuthRepositoryImpl(
            authLocalDataSource: Get.find<AuthLocalDataSource>(),
          ),
          permanent: true)
      ..put(AuthController(), permanent: true)
      ..put(LoginController(), permanent: true);
  }
}
