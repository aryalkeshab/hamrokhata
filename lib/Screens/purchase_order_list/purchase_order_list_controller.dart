import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_repository.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/response/purchase_order_response_model.dart';

class PurchaseOrderListController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //getpurchaseList
  List<PurchaseOrderList>? purchaseOrderResponseList = [];

  ApiResponse _purchaseOrderResponse = ApiResponse();

  set purchaseOrderResponse(ApiResponse response) {
    _purchaseOrderResponse = response;
    update();
  }

  ApiResponse get purchaseOrderResponse => _purchaseOrderResponse;

  getpurchaseOrderList() async {
    purchaseOrderResponse =
        await Get.find<PurchaseRepository>().getpurchaseOrderList();
    if (purchaseOrderResponse.hasData) {
      purchaseOrderResponseList = purchaseOrderResponse.data;
      update();
    } else {}
  }
}
