import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/Screens/auth/auth_repository_impl.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_repository.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/dialog_box.dart';
import 'package:hamrokhata/commons/widgets/loading_dialog.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/product_detail.dart';
import 'package:hamrokhata/models/request/otp_params.dart';
import 'package:hamrokhata/models/request/register_params.dart';

class OtpController extends GetxController {
  late AuthLoginRegisterRepository authRepository;

  @override
  void onInit() {
    authRepository = Get.find<AuthLoginRegisterRepository>();
    super.onInit();
  }

  late ApiResponse otpResopnse;

  void otpVerify(OtpParams otpParams, BuildContext context, int user_id,
      bool fromForgetPassword) async {
    showLoadingDialog(context);
    otpResopnse = await authRepository.otpAuth(OtpParams(
      otp: otpParams.otp,
      user_id: user_id,
    ));
    if (otpResopnse.hasError) {
      
      hideLoadingDialog(context);
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(otpResopnse.error));
    } else {
      hideLoadingDialog(context);
      showSuccessToast(otpResopnse.data);
      if (fromForgetPassword == true) {
        Get.toNamed(Routes.resetPasswordScreen, arguments: user_id);
      } else {
        Get.offNamed(Routes.login);
      }
    }
  }
}
