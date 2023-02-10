enum APIPath {
  //auth
  login,
  register,
  refreshToken,

  products,
  allProducts,

  productSearch,

  customerList,
  salesOrder,
  //purchase,
  purchaseOrder,
  vendorList,
  addProduct,
  categoryList,
}

class APIPathHelper {
  static const String apiUrl = "http://192.168.1.74:2112/api";

  static String authAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.login:
        return "/login/";

      case APIPath.register:
        return "/register/";

      default:
        return "";
    }
  }

  static String purchaseAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.vendorList:
        return "/vendor/";

      case APIPath.addProduct:
        return "/productlist/";

      case APIPath.purchaseOrder:
        return "/purchase/";

      default:
        return "";
    }
  }

  static String salesOrderAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.customerList:
        return "/customer";

      case APIPath.salesOrder:
        return "/sales/";

      default:
        return "";
    }
  }

  static String productSearch(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.productSearch:
        return "/product/$id";

      case APIPath.allProducts:
        return "/rest/V1/custom/products";

      case APIPath.categoryList:
        return "/categorylist";

      default:
        return "";
    }
  }
}
