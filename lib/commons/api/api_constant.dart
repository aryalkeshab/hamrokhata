enum APIPath {
  products,
  allProducts,

  vendorList,
}

class APIPathHelper {
  static const String apiUrl = "http://192.168.1.74:2112/api";

  static String purchaseAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.vendorList:
        return "/vendor";

      case APIPath.allProducts:
        return "/rest/V1/custom/products";

      default:
        return "";
    }
  }
}
