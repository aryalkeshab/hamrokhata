import 'package:hamrokhata/Screens/purchase_order/purchase_order_remote_data_source.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/get_category_list.dart';
import 'package:hamrokhata/models/request/product_request_model.dart';
import 'package:hamrokhata/models/request/purchase_request_model.dart';
import 'package:hamrokhata/models/response/purchase_order_response_model.dart';
import 'package:hamrokhata/models/request/sales_response_model.dart';
import 'package:hamrokhata/models/vendor_list.dart';

import '../purchase_order_list/purchase_order_list.dart';
import 'package:dio/dio.dart' as dio;

abstract class PurchaseRepository {
  Future<ApiResponse> getVendorsList();
  Future<ApiResponse> getCategoryList();
  Future<ApiResponse> getpurchaseOrderList();

  Future<ApiResponse> addProduct(
      ProductRequestModel productRequestModel, dio.FormData formData);
  Future<ApiResponse> purchaseOrder(PurchaseOrderModel purchaseOrderModel);
}

class PurchaseRepositoryImpl extends PurchaseRepository {
  final NetworkInfo networkInfo;
  final PurchaseOrderRemoteDataSource purchaseOrderRemoteDataSource;

  PurchaseRepositoryImpl({
    required this.networkInfo,
    required this.purchaseOrderRemoteDataSource,
  });

  @override
  Future<ApiResponse> getVendorsList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await purchaseOrderRemoteDataSource.getVendorsList();
        print(result);
        final vendorList =
            result.map<VendorList>((e) => VendorList.fromJson(e)).toList();
        print(vendorList);
        return ApiResponse(data: vendorList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
        //       if(e is DioError && e.type == DioErrorType.response){
        //     print(e.response?.data);
        //     return ApiResponse(error: NetworkException.defaultError(value:e.response?.data[0]['message']));
        //   }
        //   return ApiResponse(error: NetworkException.getException(e));
        // }
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> getCategoryList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await purchaseOrderRemoteDataSource.getCategoryList();
        print(result);
        final categoryList = result
            .map<CategoryResponseModel>(
                (e) => CategoryResponseModel.fromJson(e))
            .toList();

        return ApiResponse(data: categoryList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
        //       if(e is DioError && e.type == DioErrorType.response){
        //     print(e.response?.data);
        //     return ApiResponse(error: NetworkException.defaultError(value:e.response?.data[0]['message']));
        //   }
        //   return ApiResponse(error: NetworkException.getException(e));
        // }
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> getpurchaseOrderList() async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await purchaseOrderRemoteDataSource.getpurchaseOrderList();
        print(result);
        // final purchaseOrderResponse = PurchaseOrderList.fromJson(result);
        final purchaseOrderResponseList = result
            .map<PurchaseOrderList>((e) => PurchaseOrderList.fromJson(e))
            .toList();

        return ApiResponse(data: purchaseOrderResponseList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
        //       if(e is DioError && e.type == DioErrorType.response){
        //     print(e.response?.data);
        //     return ApiResponse(error: NetworkException.defaultError(value:e.response?.data[0]['message']));
        //   }
        //   return ApiResponse(error: NetworkException.getException(e));
        // }
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> addProduct(
      ProductRequestModel productRequestModel, dio.FormData formData) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await purchaseOrderRemoteDataSource.addProduct(
            productRequestModel, formData);

        return ApiResponse(data: "Product is Successfully Added");
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> purchaseOrder(
      PurchaseOrderModel purchaseOrderModel) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await purchaseOrderRemoteDataSource
            .purchaseOrder(purchaseOrderModel);
        print(result);
        final purchaseOrderResponse = PurchaseOrderResponse.fromJson(result);
        // final purchaseOrderResponseList = result
        //     .map<PurchaseOrderResponse>(
        //         (e) => PurchaseOrderResponse.fromJson(e))
        //     .toList();
        print(purchaseOrderResponse);
        showSuccessToast(result['msg']);
        return ApiResponse(data: purchaseOrderResponse);
      } catch (e) {
        print(e);
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
