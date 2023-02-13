import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/customer_model.dart';
import 'package:hamrokhata/models/sales_order_model.dart';
import 'package:hamrokhata/models/request/sales_response_model.dart';

class SalesOrderController extends GetxController {
  List<CustomerModel> customerApiResult = [];

  List<String> customerList = [];

  ApiResponse _customerListResponse = ApiResponse();

  set customerlistResponse(ApiResponse response) {
    _customerListResponse = response;
    update();
  }

  ApiResponse get customerlistResponse => _customerListResponse;

  getcustomerList() async {
    customerlistResponse =
        await Get.find<SalesOrderRepository>().getCustomerList();
    customerList = [];
    if (customerlistResponse.hasData) {
      customerApiResult = await customerlistResponse.data;

      for (int i = 0; i < customerApiResult.length; i++) {
        customerList.add(customerApiResult[i].name!);
        update();
      }
    }

    update();
  }

  SalesOrderResponse? salesOrderResponseList;

  ApiResponse _salesOrderResponse = ApiResponse();

  set salesOrderResponse(ApiResponse response) {
    _salesOrderResponse = response;
    update();
  }

  ApiResponse get salesOrderResponse => _salesOrderResponse;

  salesOrder(SalesOrderModel salesOrderModel, BuildContext context) async {
    salesOrderResponse =
        await Get.find<SalesOrderRepository>().salesOrder(salesOrderModel);
    if (salesOrderResponse.hasData && context.mounted) {
      salesOrderResponseList = salesOrderResponse.data;
      showSuccessToast(salesOrderResponseList!.msg.toString());
      Get.toNamed(Routes.salesTableReceipt,
          arguments: [salesOrderResponseList!]);
      update();
    } else {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(salesOrderResponse.error));
    }
  }

  @override
  void onInit() {
    getcustomerList();
    super.onInit();
  }
}
