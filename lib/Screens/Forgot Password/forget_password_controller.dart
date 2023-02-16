import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/Screens/auth/auth_repository_impl.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_repository.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/storage_constants.dart';
import 'package:hamrokhata/commons/widgets/dialog_box.dart';
import 'package:hamrokhata/commons/widgets/loading_dialog.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/product_detail.dart';
import 'package:hamrokhata/models/request/forget_password.dart';
import 'package:hamrokhata/models/request/otp_params.dart';
import 'package:hamrokhata/models/request/register_params.dart';
import 'package:hamrokhata/models/request/reset_password_params.dart';
import 'package:hamrokhata/models/response/reset_response.dart';

class ForgetPasswordController extends GetxController {
  late AuthLoginRegisterRepository authRepository;
  final secureStorage = Get.find<FlutterSecureStorage>();

  @override
  void onInit() {
    authRepository = Get.find<AuthLoginRegisterRepository>();

    super.onInit();
  }

  late ApiResponse forgetPasswordResponse;

  void forgetPasswordVerify(
      ForgetPasswordParams forgetPasswordParams, BuildContext context) async {
    showLoadingDialog(context);
    forgetPasswordResponse =
        await authRepository.forgetPasswordAuth(forgetPasswordParams);
    if (forgetPasswordResponse.hasError) {
      hideLoadingDialog(context);
      AppSnackbar.showError(
          context: context,
          message:
              NetworkException.getErrorMessage(forgetPasswordResponse.error));
    } else {
      hideLoadingDialog(context);
      final user_id =
          await secureStorage.read(key: StorageConstants.resetpassworduserId);

      Get.toNamed(
        Routes.otpScreen,
        arguments: UserIdEmailParams(
          email: forgetPasswordParams.email,
          user_id: forgetPasswordResponse.data,
          fromForgetPassword: true,
        ),
      );
    }
  }

  late ApiResponse passwordResetResponse;

  void passwordResetAuth(
      ResetPasswordParams resetPasswordParams, BuildContext context) async {
    showLoadingDialog(context);
    passwordResetResponse =
        await authRepository.passwordResetAuth(resetPasswordParams);
    if (forgetPasswordResponse.hasError) {
      hideLoadingDialog(context);
      AppSnackbar.showError(
          context: context,
          message:
              NetworkException.getErrorMessage(passwordResetResponse.error));
    } else {
      hideLoadingDialog(context);
      showSuccessToast(passwordResetResponse.data);
      Get.toNamed(Routes.login);
    }
  }
}
