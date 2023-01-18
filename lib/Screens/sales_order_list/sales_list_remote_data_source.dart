import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';

abstract class PurchaseOrderRemoteDataSource {
  Future<dynamic> getVendorsList();
}

class PurchaseOrderRemoteDataSourceImpl extends PurchaseOrderRemoteDataSource {
  final ApiClient apiClient;
  PurchaseOrderRemoteDataSourceImpl({required this.apiClient});
  @override
  getVendorsList() {
    return apiClient.get(APIPathHelper.purchaseAPIs(APIPath.vendorList));
  }
}
