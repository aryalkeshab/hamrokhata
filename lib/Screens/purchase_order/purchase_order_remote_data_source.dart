import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/models/request/product_request_model.dart';
import 'package:hamrokhata/models/request/purchase_request_model.dart';

abstract class PurchaseOrderRemoteDataSource {
  Future<dynamic> getVendorsList();
  Future<dynamic> getCategoryList();
  Future<dynamic> addProduct(ProductRequestModel productRequestModel);
  Future<dynamic> purchaseOrder(PurchaseOrderModel purchaseOrderModel);
  Future<dynamic> getpurchaseOrderList();
}

class PurchaseOrderRemoteDataSourceImpl extends PurchaseOrderRemoteDataSource {
  final ApiClient apiClient;
  PurchaseOrderRemoteDataSourceImpl({required this.apiClient});
  @override
  getVendorsList() {
    return apiClient.authGet(APIPathHelper.purchaseAPIs(APIPath.vendorList));
  }

  @override
  getCategoryList() {
    return apiClient.authGet(APIPathHelper.productSearch(APIPath.categoryList));
  }

  @override
  addProduct(ProductRequestModel productRequestModel) {
    return apiClient.authPost(APIPathHelper.purchaseAPIs(APIPath.addProduct),
        data: productRequestModel.toJson());
  }

  @override
  purchaseOrder(PurchaseOrderModel purchaseOrderModel) {
    return apiClient.authPost(APIPathHelper.purchaseAPIs(APIPath.purchaseOrder),
        data: purchaseOrderModel.toJson());
  }

  @override
  getpurchaseOrderList() {
    return apiClient.authGet(
      APIPathHelper.purchaseAPIs(APIPath.purchaseOrder),
    );
  }
}
