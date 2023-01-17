import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/models/customer_model.dart';

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
}
