import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_remote_data_source.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/models/product_detail.dart';

abstract class ProductSearchRepository {
  Future<ApiResponse> getProductDetail(id);
}

class ProductSearchRepositoryImpl extends ProductSearchRepository {
  final NetworkInfo networkInfo;
  final ProductSearchRemoteDataSource productSearchRemoteDataSource;

  ProductSearchRepositoryImpl({
    required this.networkInfo,
    required this.productSearchRemoteDataSource,
  });

  @override
  Future<ApiResponse> getProductDetail(id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productSearchRemoteDataSource.getProductDetail(id);
        print(result);
        final productDetails =
            ProductSearchResponse.fromJson(result["data"][0]);

        return ApiResponse(data: productDetails);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.response) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  // value: e.response?.data['message'].toString()
                  value: "Product not found"));
        }
        print(e);
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
