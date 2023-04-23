import 'package:hamrokhata/Screens/sales_order/sales_order_screen.dart';
import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/models/request/sales_list_request_params.dart';
import 'package:hamrokhata/models/request/sales_order_model.dart';

abstract class SalesOrderRemoteDataSource {
  Future<dynamic> getCustomerList();
  Future<dynamic> salesOrder(SalesOrderModel salesOrderModel);
  Future<dynamic> salesOrderList(SalesListRequestParams salesListRequestParams);
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
  salesOrder(SalesOrderModel salesOrderModel) {
    return apiClient.authPost(APIPathHelper.salesOrderAPIs(APIPath.salesOrder),
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
