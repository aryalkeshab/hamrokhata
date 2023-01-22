import 'package:hamrokhata/Screens/sales_order/sales_order_remote_data_source.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_screen.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/models/customer_model.dart';
import 'package:hamrokhata/models/sales_order_model.dart';
import 'package:hamrokhata/models/vendor_list.dart';

abstract class SalesOrderRepository {
  Future<ApiResponse> getCustomerList();
  Future<ApiResponse> salesOrder(SalesOrderModel salesOrderModel);
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

  @override
  Future<ApiResponse> salesOrder(SalesOrderModel salesOrderModel) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await salesOrderRemoteDataSource.salesOrder(salesOrderModel);
        final salesOrderResponseList = result
            .map<SalesOrderModel>((e) => SalesOrderModel.fromJson(e))
            .toList();

        return ApiResponse(data: salesOrderResponseList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
