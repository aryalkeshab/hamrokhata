import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/commons/api/auth_interceptor.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CoreBindings extends Bindings {
  @override
  void dependencies() {
    const baseUrl = APIPathHelper.apiUrl;
    Get
      ..put(const FlutterSecureStorage(), permanent: true)
      ..put(Dio(), permanent: true)
      ..put(InternetConnectionChecker(), permanent: true)
      ..put<NetworkInfo>(
          NetworkInfoImpl(
              dataConnectionChecker: Get.find<InternetConnectionChecker>()),
          permanent: true)
      ..put(AuthInterceptor(Get.find<Dio>(), Get.find<FlutterSecureStorage>()),
          permanent: true)
      ..put(
          ApiClient(
              baseUrl: baseUrl,
              dio: Get.find<Dio>(),
              interceptor: Get.find<AuthInterceptor>()),
          permanent: true);
  }
}
