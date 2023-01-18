import 'package:get/get.dart';
import 'package:hamrokhata/Screens/product_detail/product_detail_controller.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_remote_data_source.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_repository.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_controller.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_remote_data_source.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_repository.dart';
import 'package:hamrokhata/commons/api/api_client.dart';
import 'package:hamrokhata/commons/api/network_info.dart';

class ProductSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<ProductSearchRemoteDataSource>(
          ProductSearchRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<ProductSearchRepository>(ProductSearchRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          productSearchRemoteDataSource:
              Get.find<ProductSearchRemoteDataSource>()))
      ..put(ProductDetailsController());
  }
}
