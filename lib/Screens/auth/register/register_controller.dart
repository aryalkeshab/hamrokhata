import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_repository.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/widgets/dialog_box.dart';
import 'package:hamrokhata/commons/widgets/loading_dialog.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/product_detail.dart';
import 'package:hamrokhata/models/request/register_params.dart';

class RegisterController extends GetxController {
  late AuthLoginRegisterRepository registerRepository;

  @override
  void onInit() {
    registerRepository = Get.find<AuthLoginRegisterRepository>();
    super.onInit();
  }

  late ApiResponse registerResponse;

  void requestRegister(
      RegisterParams registerParams, BuildContext context) async {
    showLoadingDialog(context);
    registerResponse = await registerRepository.registerAuth(registerParams);
    hideLoadingDialog(context);
    if (registerResponse.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(registerResponse.error));
    } else {
      showSuccessToast(registerResponse.data);
      Get.back();
    }
  }
}
