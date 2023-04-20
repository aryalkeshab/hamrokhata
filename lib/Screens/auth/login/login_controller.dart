import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_repository.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/loading_dialog.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/request/login_params.dart';

import '../../../commons/api/storage_constants.dart';

class LoginController extends GetxController {
  // final Dio _dio = Dio();
  late ApiResponse loginResponse;
  final secureStorage = Get.find<FlutterSecureStorage>();

  void requestLogin(LoginParams loginParams, BuildContext context) async {
    // Get.offAndToNamed(Routes.dashboard);

    showLoadingDialog(context);
    loginResponse =
        await Get.find<AuthLoginRegisterRepository>().loginAuth(loginParams);

    if (loginResponse.hasData) {
      hideLoadingDialog(context);
      showSuccessToast(loginResponse.data);
      Get.find<AuthController>().authorize();
      await secureStorage.write(
          key: StorageConstants.isLoggedIn, value: "true");

      //           try {
      //   final response = await _dio.get(
      //     '/customer/',
      //   );
      //   print(response);
      //   if (response.statusCode == 401) {
      //     showErrorToast(
      //         "You are not Authorized to Login!\n Please contact Admin");
      //   } else {
      //     print(" SUccess here");
      //     Get.find<AuthController>().authorize();
      //     //   await secureStorage.write(
      //     //       key: StorageConstants.isLoggedIn, value: "true");
      //     showSuccessToast(loginResponse.data);
      //   }
      // } catch (e) {
      //   print(" SUccess here $e");
      //   print(e);
      // }
    } else {
      hideLoadingDialog(context);
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(loginResponse.error));
    }
  }
}
