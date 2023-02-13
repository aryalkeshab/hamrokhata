import 'package:get/get.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_controller.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_remote_data_source.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_repository.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list_controller.dart';
import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/network_info.dart';

class PurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<PurchaseOrderRemoteDataSource>(
          PurchaseOrderRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<PurchaseRepository>(PurchaseRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          purchaseOrderRemoteDataSource:
              Get.find<PurchaseOrderRemoteDataSource>()))
      ..put(PurchaseOrderController())
      ..put(PurchaseOrderListController());
  }
}
