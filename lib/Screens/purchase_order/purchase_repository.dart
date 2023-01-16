import 'package:hamrokhata/Screens/purchase_order/purchase_order_remote_data_source.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/models/vendor_list.dart';

abstract class PurchaseRepository {
  Future<ApiResponse> getVendorsList();
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
        // final vendorList = result[0].map<VendorList>(VendorList).toList();
        final vendorList =
            result.map<VendorList>((e) => VendorList.fromJson(e)).toList();
        print(vendorList);
        return ApiResponse(data: vendorList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
