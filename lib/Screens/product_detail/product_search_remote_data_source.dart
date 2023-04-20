import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/models/request/product_search_request_model.dart';

abstract class ProductSearchRemoteDataSource {
  Future<dynamic> getProductDetail(
      ProductSearchRequestModel productSearchRequestModel);
}

class ProductSearchRemoteDataSourceImpl extends ProductSearchRemoteDataSource {
  final ApiClient apiClient;
  ProductSearchRemoteDataSourceImpl({required this.apiClient});
  @override
  getProductDetail(ProductSearchRequestModel productSearchRequestModel) {
    return apiClient.authGet(
        APIPathHelper.productSearch(
          APIPath.productSearch,
        ),
        queryParameters: productSearchRequestModel.toJson());
  }
}
