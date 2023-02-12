import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/Pin%20Code/Pin_Code_Screen.dart';
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
import 'package:hamrokhata/models/request/forget_password.dart';
import 'package:hamrokhata/models/request/otp_params.dart';
import 'package:hamrokhata/models/request/register_params.dart';

class ForgetPasswordController extends GetxController {
  late AuthLoginRegisterRepository authRepository;

  @override
  void onInit() {
    authRepository = Get.find<AuthLoginRegisterRepository>();
    final secureStorage = Get.find<FlutterSecureStorage>();

    super.onInit();
  }

  late ApiResponse forgetPasswordResponse;

  void forgetPasswordVerify(
      ForgetPasswordParams forgetPasswordParams, BuildContext context) async {
    showLoadingDialog(context);
    forgetPasswordResponse =
        await authRepository.forgetPasswordAuth(forgetPasswordParams);
    if (forgetPasswordResponse.hasError && context.mounted) {
      hideLoadingDialog(context);
      AppSnackbar.showError(
          context: context,
          message:
              NetworkException.getErrorMessage(forgetPasswordResponse.error));
    } else {
      hideLoadingDialog(context);
      // showSuccessToast(forgetPasswordResponse.data);

      Navigator.pop(context);
      // // Navigator.push(
      // //   context,
      // //   MaterialPageRoute(
      // //     builder: (context) => PinCodeVerificationScreen(
      // //       email: forgetPasswordParams.email,
      // //       user_id: forgetPasswordResponse.data,
      // //     ),
      // //   ),
      // // );

      // Get.toNamed(Routes.otpScreen, arguments: [
      //   forgetPasswordParams.email,
      //   forgetPasswordResponse.data
      // ]);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return PinCodeVerificationScreen(
          email: forgetPasswordParams.email,
          user_id: forgetPasswordResponse.data,
        );
      }));
    }
  }
}
