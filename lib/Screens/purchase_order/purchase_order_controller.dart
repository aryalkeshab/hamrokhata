import 'package:get/get.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/models/vendor_list.dart';

class PurchaseOrderController extends GetxController {
  @override
  void onInit() {
    getVendorsList();
    super.onInit();
  }

  List<VendorList> vendorApiResult = [];

  List<String> vendorList = [];

  ApiResponse _vendorsListResponse = ApiResponse();

  set vendorslistResponse(ApiResponse response) {
    _vendorsListResponse = response;
    update();
  }

  ApiResponse get vendorslistResponse => _vendorsListResponse;

  getVendorsList() async {
    vendorslistResponse = await Get.find<PurchaseRepository>().getVendorsList();
    vendorList = [];
    if (vendorslistResponse.hasData) {
      vendorApiResult = await vendorslistResponse.data;

      for (int i = 0; i < vendorApiResult.length; i++) {
        vendorList.add(vendorApiResult[i].name!);
        update();
      }
    }

    update();
  }
}
