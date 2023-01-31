import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/widgets/loading_dialog.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/get_category_list.dart';
import 'package:hamrokhata/models/request/product_request_model.dart';
import 'package:hamrokhata/models/vendor_list.dart';

class PurchaseOrderController extends GetxController {
  @override
  void onInit() {
    getVendorsList();
    getCategoryList();

    super.onInit();
  }

  List<VendorList> vendorApiResult = [];
  List<CategoryResponseModel> categoryModelList = [];

  List<String> vendorList = [];
  List<String> categoryList = [];

  ApiResponse _vendorsListResponse = ApiResponse();

  set vendorslistResponse(ApiResponse response) {
    _vendorsListResponse = response;
    update();
  }

  ApiResponse get vendorslistResponse => _vendorsListResponse;

  void getVendorsList() async {
    vendorslistResponse = await Get.find<PurchaseRepository>().getVendorsList();
    vendorList = [];
    if (vendorslistResponse.hasData) {
      vendorApiResult = await vendorslistResponse.data;

      for (int i = 0; i < vendorApiResult.length; i++) {
        vendorList.add(vendorApiResult[i].name!);
        update();
      }
    } else {
      showErrorToast(
          NetworkException.getErrorMessage(vendorslistResponse.error));
    }

    update();
  }

  ApiResponse _categoryListResponse = ApiResponse();

  set categoryListResponse(ApiResponse response) {
    _categoryListResponse = response;
    update();
  }

  ApiResponse get categoryListResponse => _categoryListResponse;

  void getCategoryList() async {
    categoryListResponse =
        await Get.find<PurchaseRepository>().getCategoryList();
    categoryList = [];
    if (categoryListResponse.hasData) {
      categoryModelList = await categoryListResponse.data;

      for (int i = 0; i < categoryModelList.length; i++) {
        categoryList.add(categoryModelList[i].name!);
        update();
      }
    } else {
      showErrorToast(
          NetworkException.getErrorMessage(vendorslistResponse.error));
    }

    update();
  }

  late ApiResponse purchaseOrderResponse;

  void createPurchaseOrder(
      ProductRequestModel productRequestModel, BuildContext context) async {
    showLoadingDialog(context);
    purchaseOrderResponse =
        await Get.find<PurchaseRepository>().purchaseOrder(productRequestModel);
    hideLoadingDialog(context);
    if (purchaseOrderResponse.hasError) {
      AppSnackbar.showError(
          context: context,
          message:
              NetworkException.getErrorMessage(purchaseOrderResponse.error));
    } else {
      showSuccessToast(purchaseOrderResponse.data);
      Get.back();
    }
  }
}
