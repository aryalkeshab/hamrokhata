import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/models/request/product_request_model.dart';
import 'package:hamrokhata/models/request/purchase_list_request_params.dart';
import 'package:hamrokhata/models/request/purchase_request_model.dart';
import 'package:supercharged/supercharged.dart';
import 'package:dio/dio.dart' as dio;

abstract class PurchaseOrderRemoteDataSource {
  Future<dynamic> getVendorsList();
  Future<dynamic> getCategoryList();
  Future<dynamic> addProduct(
      ProductRequestModel productRequestModel, dio.FormData formData);
  Future<dynamic> purchaseOrder(PurchaseOrderModel purchaseOrderModel);
  Future<dynamic> getpurchaseOrderList(
      PurchaseListRequestParams purchaseListRequestParams);
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
  addProduct(ProductRequestModel productRequestModel, dio.FormData formData) {
    return apiClient.authPost(
      APIPathHelper.purchaseAPIs(APIPath.addProduct),
      data: formData,
    );
  }

  @override
  purchaseOrder(PurchaseOrderModel purchaseOrderModel) {
    return apiClient.authPost(APIPathHelper.purchaseAPIs(APIPath.purchaseOrder),
        data: purchaseOrderModel.toJson());
  }

  @override
  getpurchaseOrderList(PurchaseListRequestParams purchaseListRequestParams) {
    return apiClient.authGet(
        APIPathHelper.purchaseAPIs(
          APIPath.purchaseOrder,
        ),
        queryParameters: purchaseListRequestParams.toJson());
  }
}
