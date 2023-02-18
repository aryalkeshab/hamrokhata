import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/loading_dialog.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/get_category_list.dart';
import 'package:hamrokhata/models/request/product_request_model.dart';
import 'package:hamrokhata/models/request/purchase_request_model.dart';
import 'package:hamrokhata/models/response/purchase_order_response_model.dart';
import 'package:hamrokhata/models/vendor_list.dart';

class PurchaseOrderController extends GetxController {
  @override
  void onInit() async {
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

//product Add
  late ApiResponse productOrderResponse;

  void addProduct(
      ProductRequestModel productRequestModel, BuildContext context) async {
    showLoadingDialog(context);
    productOrderResponse =
        await Get.find<PurchaseRepository>().addProduct(productRequestModel);
    hideLoadingDialog(context);
    if (productOrderResponse.hasError) {
      AppSnackbar.showError(
          context: context,
          message:
              NetworkException.getErrorMessage(productOrderResponse.error));
    } else {
      showSuccessToast(productOrderResponse.data);
      Get.back();
    }
  }

  // Create purchase order

  PurchaseOrderResponse? purchaseOrderResponseList;

  ApiResponse _purchaseOrderResponse = ApiResponse();

  set purchaseOrderResponse(ApiResponse response) {
    _purchaseOrderResponse = response;
    update();
  }

  ApiResponse get purchaseOrderResponse => _purchaseOrderResponse;

  createPurchaseOrder(
      PurchaseOrderModel purchaseOrderModel, BuildContext context) async {
    purchaseOrderResponse =
        await Get.find<PurchaseRepository>().purchaseOrder(purchaseOrderModel);
    if (purchaseOrderResponse.hasData) {
      purchaseOrderResponseList = purchaseOrderResponse.data;
      // showNormalToast(purchaseOrderResponseList!.msg.toString());
      Get.toNamed(Routes.purchaseOrderReceipt,
          arguments: [purchaseOrderResponseList!]);
      update();
    } else {
      AppSnackbar.showError(
          context: context,
          message:
              NetworkException.getErrorMessage(purchaseOrderResponse.error));
    }
  }
}
