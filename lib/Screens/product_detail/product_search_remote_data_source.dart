import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';

abstract class ProductSearchRemoteDataSource {
  Future<dynamic> getProductDetail(id);
}

class ProductSearchRemoteDataSourceImpl extends ProductSearchRemoteDataSource {
  final ApiClient apiClient;
  ProductSearchRemoteDataSourceImpl({required this.apiClient});
  @override
  getProductDetail(id) {
    return apiClient
        .get(APIPathHelper.productSearch(APIPath.productSearch, id: id));
  }
}
