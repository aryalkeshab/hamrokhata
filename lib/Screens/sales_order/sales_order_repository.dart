import 'package:hamrokhata/Screens/sales_order/sales_order_remote_data_source.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/models/customer_model.dart';
import 'package:hamrokhata/models/vendor_list.dart';

abstract class SalesOrderRepository {
  Future<ApiResponse> getCustomerList();
}

class SalesOrderRepositoryImpl extends SalesOrderRepository {
  final NetworkInfo networkInfo;
  final SalesOrderRemoteDataSource salesOrderRemoteDataSource;

  SalesOrderRepositoryImpl({
    required this.networkInfo,
    required this.salesOrderRemoteDataSource,
  });

  @override
  Future<ApiResponse> getCustomerList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await salesOrderRemoteDataSource.getCustomerList();
        print(result);
        final vendorList = result
            .map<CustomerModel>((e) => CustomerModel.fromJson(e))
            .toList();

        return ApiResponse(data: vendorList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
