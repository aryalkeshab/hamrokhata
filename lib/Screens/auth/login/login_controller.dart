import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/widgets/loading_dialog.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/request/login_params.dart';

class LoginController extends GetxController {
  late ApiResponse loginResponse;

  void requestLogin(LoginParams loginParams, BuildContext context) async {
    showLoadingDialog(context);
    loginResponse =
        await Get.find<AuthLoginRegisterRepository>().loginAuth(loginParams);
    hideLoadingDialog(context);
    if (loginResponse.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(loginResponse.error));
    } else {
      showSuccessToast(loginResponse.data);
      Get.find<AuthController>().authorize();
      Get.back();
    }
  }
}
