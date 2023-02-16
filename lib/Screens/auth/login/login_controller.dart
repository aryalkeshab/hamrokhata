import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/widgets/loading_dialog.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/request/login_params.dart';

import '../../../commons/api/storage_constants.dart';

class LoginController extends GetxController {
  late ApiResponse loginResponse;
  final secureStorage = Get.find<FlutterSecureStorage>();

  void requestLogin(LoginParams loginParams, BuildContext context) async {
    showLoadingDialog(context);
    loginResponse =
        await Get.find<AuthLoginRegisterRepository>().loginAuth(loginParams);

    if (loginResponse.hasData) {
      hideLoadingDialog(context);
      showSuccessToast(loginResponse.data);
      Get.find<AuthController>().authorize();
      await secureStorage.write(
          key: StorageConstants.isLoggedIn, value: "true");
    } else {
      hideLoadingDialog(context);
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(loginResponse.error));
    }
  }
}
