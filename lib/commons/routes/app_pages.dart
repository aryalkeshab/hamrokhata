import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hamrokhata/Screens/Forgot%20Password/Forgot_Password_Screen.dart';
import 'package:hamrokhata/Screens/Forgot%20Password/reset_password_screen.dart';
import 'package:hamrokhata/Screens/Pin%20Code/otp_screen.dart';
import 'package:hamrokhata/Screens/Receipt_table/sales_order_receipt.dart';
import 'package:hamrokhata/Screens/Receipt_table/sales_receipt.dart';
import 'package:hamrokhata/Screens/auth/auth_di.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_bindings.dart';
import 'package:hamrokhata/Screens/auth/register/register.dart';
import 'package:hamrokhata/Screens/bluetooth/app_setting.dart';
import 'package:hamrokhata/Screens/bluetooth/bluetooth_device_list_screen.dart';
import 'package:hamrokhata/Screens/change_password.dart/change_password.dart';
import 'package:hamrokhata/Screens/create_products/add_product_screen.dart';
import 'package:hamrokhata/Screens/dashboard/dashboard.dart';
import 'package:hamrokhata/Screens/intro_screens/intro_screen.dart';
import 'package:hamrokhata/Screens/product_detail/product_details_screen.dart';
import 'package:hamrokhata/Screens/product_detail/product_search_di.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_di.dart';
import 'package:hamrokhata/Screens/Receipt_table/purchase_order_receipt.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_screen.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list_screen.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_di.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_screen.dart';
import 'package:hamrokhata/Screens/sales_order_list/sales_order_list.dart';
import 'package:hamrokhata/Screens/splash/splash_screen.dart';
import 'package:hamrokhata/commons/api/core_bindings.dart';
import 'package:hamrokhata/models/response/reset_response.dart';
import 'package:hamrokhata/Screens/Receipt_table/Receipt-Screen.dart';

import '../../Screens/auth/login/login.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  final initial = Routes.dashboard;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: SplashScreen.new,
      bindings: [
        CoreBindings(),
        AuthBinding(),
      ],
    ),
    GetPage(
      name: _Paths.otpScreen,
      page: () => OTPVerificationScreen(
        userIdEmailParams: Get.arguments,
      ),
      bindings: [
        // CoreBindings(),
        // AuthBinding(),
        LoginBindings(),
      ],
    ),
    GetPage(
      name: _Paths.login,
      page: LoginScreen.new,
      bindings: [
        // CoreBindings(),
        LoginBindings(),
        // AuthBinding(),
        SalesOrderBinding(),
      ],
    ),

    GetPage(
      name: _Paths.forgotPasswordScreen,
      page: ForgotPasswordScreen.new,
      bindings: [
        // CoreBindings(),
        // AuthBinding(),
        LoginBindings(),
      ],
    ),

    GetPage(
      name: _Paths.dashboard,
      page: DashBoardScreen.new,
      bindings: [
        // CoreBindings(),
        // AuthBinding(),
      ],
    ),
    GetPage(
      name: _Paths.resetPasswordScreen,
      page: () => ResetPasswordScreen(user_id: Get.arguments),
    ),
    GetPage(
      name: _Paths.register,
      page: RegisterScreen.new,
    ),
    GetPage(
      name: _Paths.table,
      page: () => TableForReceipt(
        purchaseOrderList: Get.arguments,
      ),
    ),
    GetPage(
      name: _Paths.tableForSalesReceipt,
      page: () => TableForSalesReceipt(
        salesOrderListResponse: Get.arguments,
        // purchaseOrderList: Get.arguments,
      ),
    ),

    GetPage(
      name: _Paths.changePasswordScreeen,
      page: ChangePasswordScreeen.new,
      bindings: [
        CoreBindings(),
        AuthBinding(),
        LoginBindings(),
      ],
    ),

    GetPage(
        name: _Paths.salesOrderList,
        page: SalesOrderListScreen.new,
        bindings: [
          CoreBindings(),
          SalesOrderBinding(),
        ]),
    GetPage(
      name: _Paths.purchaseOrderList,
      page: PurchaseOrderListScreen.new,
      bindings: [
        CoreBindings(),
        ProductSearchBinding(),
        PurchaseBinding(),
      ],
    ),
    GetPage(
      name: _Paths.purchaseOrder,
      page: PurchaseOrderScreen.new,
      bindings: [
        CoreBindings(),
        ProductSearchBinding(),
        PurchaseBinding(),
        SalesOrderBinding(),
      ],
    ),
    GetPage(
      name: _Paths.salesOrder,
      page: SalesOrderScreen.new,
      bindings: [
        CoreBindings(),
        SalesOrderBinding(),
        ProductSearchBinding(),
      ],
    ),
    GetPage(
      name: _Paths.appSetting,
      page: AppSetting.new,
      bindings: [
        CoreBindings(),
      ],
    ),
    // GetPage(
    //   name: _Paths.appSetting,
    //   page: AppSetting.new,
    // ),
    GetPage(
      name: _Paths.productDetails,
      page: ProductDetails.new,
      bindings: [
        CoreBindings(),
        ProductSearchBinding(),
      ],
    ),
    GetPage(
      name: _Paths.addProductScreen,
      page: AddProductScreen.new,
      bindings: [
        CoreBindings(),
        SalesOrderBinding(),
        ProductSearchBinding(),
        PurchaseBinding(),
      ],
    ),
    GetPage(name: _Paths.introScreen, page: IntroScreen.new),
    GetPage(
      name: _Paths.purchaseOrderReceipt,
      page: () => PurchaseOrderReceipt(purchaseOrderResponse: Get.arguments
          //  [0],
          // vendorName: Get.arguments[1],
          ),
    ),
    GetPage(
      name: _Paths.salesTableReceipt,
      page: () => SalesOrderReceipt(
        salesOrderResponse: Get.arguments,
      ),
    ),
    GetPage(
      name: _Paths.bluetoothDeviceScreen,
      page: BluetoothDeviceScreen.new,
    ),
  ];
}
