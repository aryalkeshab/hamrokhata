import 'package:hamrokhata/Screens/purchase_order/purchase_order_remote_data_source.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/request/product_request_model.dart';
import 'package:hamrokhata/models/vendor_list.dart';

abstract class PurchaseRepository {
  Future<ApiResponse> getVendorsList();
  Future<ApiResponse> purchaseOrder(ProductRequestModel productRequestModel);
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
  Future<ApiResponse> purchaseOrder(
      ProductRequestModel productRequestModel) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await purchaseOrderRemoteDataSource
            .purchaseOrder(productRequestModel);

        return ApiResponse(data: "Product is Successfully Added");
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
