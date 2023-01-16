import 'package:get/get.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/models/vendor_list.dart';

class PurchaseOrderController extends GetxController {
  @override
  void onInit() {
    getWishList();
    super.onInit();
  }

  List<VendorList> vendorList = [];

  ApiResponse _wishListResponse = ApiResponse();

  set wishlistResponse(ApiResponse response) {
    _wishListResponse = response;
    update();
  }

  ApiResponse get wishlistResponse => _wishListResponse;

  getWishList() async {
    wishlistResponse = await Get.find<PurchaseRepository>().getVendorsList();
    if (wishlistResponse.hasData) {
      vendorList = wishlistResponse.data;
      print(vendorList[0].name);
      update();
    }
    print(wishlistResponse.error);
    update();
  }
}
