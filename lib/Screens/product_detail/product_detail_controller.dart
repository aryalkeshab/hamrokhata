import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/widgets/dialog_box.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/product_detail.dart';

class ProductDetailsController extends GetxController {
  List<ProductSearchResponse> productDetails = [];

  ApiResponse _productSearchResponse = ApiResponse();

  set productSearchResponse(ApiResponse response) {
    _productSearchResponse = response;
    update();
  }

  ApiResponse get productSearchResponse => _productSearchResponse;

  getProductSearch(BuildContext context, id) async {
    productSearchResponse =
        await Get.find<ProductSearchRepository>().getProductDetail(id);
    if (productSearchResponse.hasError) {
      AppSnackbar.showError(
          context: context,
          message:
              NetworkException.getErrorMessage(productSearchResponse.error));
      // productDetails = await productSearchResponse.data;
    }

    update();
  }
}
