import 'package:hamrokhata/Screens/sales_order/sales_order_remote_data_source.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_screen.dart';
import 'package:hamrokhata/Screens/sales_order_list/sakes_order_list_model.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/models/customer_model.dart';
import 'package:hamrokhata/models/response/sales_order_list.dart';
import 'package:hamrokhata/models/sales_order_model.dart';
import 'package:hamrokhata/models/request/sales_response_model.dart';
import 'package:hamrokhata/models/vendor_list.dart';

abstract class SalesOrderRepository {
  Future<ApiResponse> getCustomerList();
  Future<ApiResponse> salesOrder(SalesOrderModel salesOrderModel);
  Future<ApiResponse> salesOrderList();
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
        final customerList = result
            .map<CustomerModel>((e) => CustomerModel.fromJson(e))
            .toList();

        return ApiResponse(data: customerList);
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
        print(result);

        final salesOrderResponseList = SalesOrderResponse.fromJson(result);

        return ApiResponse(data: salesOrderResponseList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> salesOrderList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await salesOrderRemoteDataSource.salesOrderList();
        print(result);

        final salesOrderResponseList = result
            .map<SalesOrderListResponse>(
                (e) => SalesOrderListResponse.fromJson(e))
            .toList();

        //I will implemnet this thing below.
        // final salesOrderResponseList = SalesResponseModel.fromJson(result[0]);

        return ApiResponse(data: salesOrderResponseList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
