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
  //auth
  otpAuth,
  changePasswordAuth,
  forgetPasswordAuth,
  resetPassword,
  salesOrderUpdate,
}

// TODO:
class APIPathHelper {
  // home
  static const String apiUrl = "http://172.20.10.4:2122/api";
  //office
  // static const String apiUrl = "http://192.168.0.96:2122/api";

  static const String imageUrl = "http://172.20.10.4:2122";

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

      case APIPath.otpAuth:
        return "/checkotp/";

      case APIPath.changePasswordAuth:
        return "/changepassword/";

      case APIPath.forgetPasswordAuth:
        return "/passwordreset/";

      case APIPath.resetPassword:
        return "/passwordresetconfirm/$id/";

      case APIPath.refreshToken:
        return "/token/refresh/";

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
      case APIPath.salesOrderUpdate:
        return "/sales/$id";

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
        return "/productlist/";

      case APIPath.allProducts:
        return "/rest/V1/custom/products";

      case APIPath.categoryList:
        return "/categorylist";

      default:
        return "";
    }
  }
}
