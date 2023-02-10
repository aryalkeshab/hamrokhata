import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hamrokhata/Screens/auth/auth_di.dart';
import 'package:hamrokhata/Screens/auth/login/login.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_bindings.dart';
import 'package:hamrokhata/Screens/auth/register/register.dart';
import 'package:hamrokhata/Screens/bluetooth/app_setting.dart';
import 'package:hamrokhata/Screens/bluetooth/bluetooth_device_list_screen.dart';
import 'package:hamrokhata/Screens/create_products/add_product_screen.dart';
import 'package:hamrokhata/Screens/dashboard/dashboard.dart';
import 'package:hamrokhata/Screens/intro_screens/intro_screen.dart';
import 'package:hamrokhata/Screens/product_detail/product_details_screen.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_di.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_di.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_screen.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_conform_screen.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_di.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_screen.dart';
import 'package:hamrokhata/Screens/sales_order_list/sales_order_list.dart';
import 'package:hamrokhata/Screens/splash/splash_screen.dart';
import 'package:hamrokhata/commons/api/core_bindings.dart';
import 'package:hamrokhata/test.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  final initial = Routes.dashboard;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: SplashScreen.new,
    ),
    GetPage(
      name: _Paths.test,
      page: TableForReceipt.new,
    ),
    GetPage(name: _Paths.login, page: LoginScreen.new, bindings: [
      CoreBindings(),
      LoginBindings(),
      AuthBinding(),
    ]),
    GetPage(name: _Paths.dashboard, page: DashBoardScreen.new, bindings: [
      CoreBindings(),
      AuthBinding(),
    ]),
    GetPage(
      name: _Paths.register,
      page: RegisterScreen.new,
    ),
    GetPage(name: _Paths.salesOrderList, page: SalesOrderList.new, bindings: [
      CoreBindings(),
      ProductSearchBinding(),
      PurchaseBinding(),
      SalesOrderBinding(),
    ]),
    GetPage(
        name: _Paths.purchaseOrder,
        page: PurchaseOrderScreen.new,
        bindings: [
          CoreBindings(),
          ProductSearchBinding(),
          PurchaseBinding(),
          SalesOrderBinding(),
        ]),
    GetPage(name: _Paths.salesOrder, page: SalesOrderScreen.new, bindings: [
      CoreBindings(),
      SalesOrderBinding(),
      ProductSearchBinding(),
    ]),
    GetPage(name: _Paths.appSetting, page: AppSetting.new, bindings: [
      CoreBindings(),
    ]),
    // GetPage(
    //   name: _Paths.appSetting,
    //   page: AppSetting.new,
    // ),
    GetPage(name: _Paths.productDetails, page: ProductDetails.new, bindings: [
      CoreBindings(),
      ProductSearchBinding(),
    ]),
    GetPage(
        name: _Paths.salesOrderConformationScreen,
        page: () => SalesOrderListScreen(salesList: Get.arguments),
        bindings: [
          CoreBindings(),
          SalesOrderBinding(),
          ProductSearchBinding(),
        ]),
    GetPage(
        name: _Paths.addProductScreen,
        page: AddProductScreen.new,
        bindings: [
          CoreBindings(),
          SalesOrderBinding(),
          ProductSearchBinding(),
          PurchaseBinding(),
        ]),
    GetPage(name: _Paths.introScreen, page: IntroScreen.new)
  ];
}
