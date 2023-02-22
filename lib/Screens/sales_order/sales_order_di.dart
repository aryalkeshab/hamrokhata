import 'package:get/get.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_remote_data_source.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_repository.dart';
import 'package:hamrokhata/Screens/sales_order_list/sales_order_list_controller.dart';

import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/network_info.dart';

class SalesOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<SalesOrderRemoteDataSource>(
          SalesOrderRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<SalesOrderRepository>(SalesOrderRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          salesOrderRemoteDataSource: Get.find<SalesOrderRemoteDataSource>()))
      ..put(SalesOrderController(), permanent: true)
      ..put(SalesOrderListController(), permanent: true);
  }
}
