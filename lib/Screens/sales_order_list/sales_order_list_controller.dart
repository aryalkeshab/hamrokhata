import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hamrokhata/Screens/sales_order/sales_order_repository.dart';
import 'package:hamrokhata/Screens/sales_order_list/sakes_order_list_model.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/models/request/sales_list_request_params.dart';

import 'package:hamrokhata/models/response/sales_order_list.dart';

class SalesOrderListController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //getSalesList
  List<SalesOrderList>? salesOrderResponseList = [];

  ApiResponse _salesOrderResponse = ApiResponse();

  set salesOrderResponse(ApiResponse response) {
    _salesOrderResponse = response;
    update();
  }

  ApiResponse get salesOrderResponse => _salesOrderResponse;

  getsalesOrderList(SalesListRequestParams salesListRequestParams) async {
    salesOrderResponse = await Get.find<SalesOrderRepository>()
        .salesOrderList(salesListRequestParams);
    if (salesOrderResponse.hasData) {
      salesOrderResponseList = salesOrderResponse.data;
      update();
    } else {}
  }
}
