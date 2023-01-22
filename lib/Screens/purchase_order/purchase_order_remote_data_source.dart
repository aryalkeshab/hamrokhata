import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/models/request/product_request_model.dart';

abstract class PurchaseOrderRemoteDataSource {
  Future<dynamic> getVendorsList();
  Future<dynamic> purchaseOrder(ProductRequestModel productRequestModel);
}

class PurchaseOrderRemoteDataSourceImpl extends PurchaseOrderRemoteDataSource {
  final ApiClient apiClient;
  PurchaseOrderRemoteDataSourceImpl({required this.apiClient});
  @override
  getVendorsList() {
    return apiClient.authGet(APIPathHelper.purchaseAPIs(APIPath.vendorList));
  }

  @override
  purchaseOrder(ProductRequestModel productRequestModel) {
    return apiClient.authPost(APIPathHelper.purchaseAPIs(APIPath.addProduct),
        data: productRequestModel.toJson());
  }
}
