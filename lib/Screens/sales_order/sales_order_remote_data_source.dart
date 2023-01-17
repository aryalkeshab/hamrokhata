import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';

abstract class SalesOrderRemoteDataSource {
  Future<dynamic> getCustomerList();
}

class SalesOrderRemoteDataSourceImpl extends SalesOrderRemoteDataSource {
  final ApiClient apiClient;
  SalesOrderRemoteDataSourceImpl({required this.apiClient});
  @override
  getCustomerList() {
    return apiClient.get(APIPathHelper.salesOrderAPIs(APIPath.customerList));
  }
}
