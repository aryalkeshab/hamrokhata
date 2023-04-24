import 'package:hamrokhata/Screens/sales_order/sales_order_remote_data_source.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_screen.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/api/network_info.dart';
import 'package:hamrokhata/models/customer_model.dart';
import 'package:hamrokhata/models/request/sales_list_request_params.dart';
import 'package:hamrokhata/models/response/sales_order_list.dart';
import 'package:hamrokhata/models/request/sales_order_model.dart';
import 'package:hamrokhata/models/response/sales_response_model.dart';
import 'package:hamrokhata/models/vendor_list.dart';

abstract class SalesOrderRepository {
  Future<ApiResponse> getCustomerList();
  Future<ApiResponse> salesOrder(SalesOrderRequestModel salesOrderModel);
  Future<ApiResponse> salesOrderUpdate(
      SalesOrderRequestModel salesOrderModel, int id);

  Future<ApiResponse> salesOrderList(
      SalesListRequestParams salesListRequestParams);
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
  Future<ApiResponse> salesOrder(SalesOrderRequestModel salesOrderModel) async {
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
  Future<ApiResponse> salesOrderUpdate(
      SalesOrderRequestModel salesOrderModel, int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await salesOrderRemoteDataSource.salesOrderUpdate(
            salesOrderModel, id);
        if (result['status'] == 200) {
          return ApiResponse(data: result['message']);
        } else {
          return ApiResponse(
              error: NetworkException.getException(result['message']));
        }

        // final salesOrderResponseList = SalesOrderResponse.fromJson(result);

        // return ApiResponse(data: salesOrderResponseList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> salesOrderList(
      SalesListRequestParams salesListRequestParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await salesOrderRemoteDataSource
            .salesOrderList(salesListRequestParams);
        print(result);

        final salesOrderResponseList = result
            .map<SalesOrderList>((e) => SalesOrderList.fromJson(e))
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
