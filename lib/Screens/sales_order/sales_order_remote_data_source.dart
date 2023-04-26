import 'package:hamrokhata/Screens/sales_order/sales_order_screen.dart';
import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/models/request/sales_list_request_params.dart';
import 'package:hamrokhata/models/request/sales_order_model.dart';

abstract class SalesOrderRemoteDataSource {
  Future<dynamic> getCustomerList();
  Future<dynamic> salesOrder(SalesOrderRequestModel salesOrderModel);
  Future<dynamic> salesOrderList(SalesListRequestParams salesListRequestParams);
  Future<dynamic> salesOrderUpdate(
      SalesOrderRequestModel salesOrderModel, int id);
}

class SalesOrderRemoteDataSourceImpl extends SalesOrderRemoteDataSource {
  final ApiClient apiClient;
  SalesOrderRemoteDataSourceImpl({required this.apiClient});
  @override
  getCustomerList() {
    return apiClient
        .authGet(APIPathHelper.salesOrderAPIs(APIPath.customerList));
  }

  @override
  salesOrder(SalesOrderRequestModel salesOrderModel) {
    return apiClient.authPost(APIPathHelper.salesOrderAPIs(APIPath.salesOrder),
        data: salesOrderModel.toJson());
  }

  @override
  salesOrderUpdate(SalesOrderRequestModel salesOrderModel, int id) {
    return apiClient.authPut(
        APIPathHelper.salesOrderAPIs(APIPath.salesOrderUpdate,
            id: id.toString()),
        data: salesOrderModel.toJson());
  }

  @override
  salesOrderList(SalesListRequestParams salesListRequestParams) {
    return apiClient.authGet(
      APIPathHelper.salesOrderAPIs(
        APIPath.salesOrder,
      ),
      queryParameters: salesListRequestParams.toJson(),
    );
  }
}
