import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_repository.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/dialog_box.dart';
import 'package:hamrokhata/commons/widgets/loading_dialog.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/product_detail.dart';
import 'package:hamrokhata/models/request/register_params.dart';
import 'package:hamrokhata/models/response/reset_response.dart';

class RegisterController extends GetxController {
  late AuthLoginRegisterRepository registerRepository;
  final secureStorage = Get.find<FlutterSecureStorage>();

  @override
  void onInit() {
    registerRepository = Get.find<AuthLoginRegisterRepository>();
    super.onInit();
  }

  late ApiResponse registerResponse;

  void requestRegister(
    RegisterParams registerParams,
    BuildContext context,
  ) async {
    showLoadingDialog(context);
    registerResponse = await registerRepository.registerAuth(registerParams);
    if (registerResponse.hasError) {
      hideLoadingDialog(context);
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(registerResponse.error));
    } else {
      hideLoadingDialog(context);
      // showSuccessToast(registerResponse.data);

      final user_id =
          await secureStorage.read(key: StorageConstants.registeruserId);

      Get.toNamed(Routes.otpScreen,
          arguments: UserIdEmailParams(
              email: registerParams.email,
              user_id: registerResponse.data,
              fromForgetPassword: false));
    }
  }
}
