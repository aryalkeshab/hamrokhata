import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_repository.dart';
import 'package:hamrokhata/Screens/sales_order_list/sales_order_list_controller.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/api/network_exception.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/snackbar.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/customer_model.dart';
import 'package:hamrokhata/models/request/sales_list_request_params.dart';
import 'package:hamrokhata/models/request/sales_order_model.dart';
import 'package:hamrokhata/models/response/sales_response_model.dart';
import 'package:intl/intl.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class SalesOrderController extends GetxController {
  List<CustomerModel> customerApiResult = [];

  List<String> customerList = [];

  ApiResponse _customerListResponse = ApiResponse();

  set customerlistResponse(ApiResponse response) {
    _customerListResponse = response;
    update();
  }

  ApiResponse get customerlistResponse => _customerListResponse;

  getcustomerList() async {
    customerlistResponse =
        await Get.find<SalesOrderRepository>().getCustomerList();
    customerList = [];
    if (customerlistResponse.hasData) {
      customerApiResult = await customerlistResponse.data;

      for (int i = 0; i < customerApiResult.length; i++) {
        customerList.add(customerApiResult[i].name!);
        update();
      }
    }

    update();
  }

  SalesOrderResponse? salesOrderResponseList;

  ApiResponse _salesOrderResponse = ApiResponse();

  set salesOrderResponse(ApiResponse response) {
    _salesOrderResponse = response;
    update();
  }

  ApiResponse get salesOrderResponse => _salesOrderResponse;

  salesOrder(
      SalesOrderRequestModel salesOrderModel, BuildContext context) async {
    salesOrderResponse =
        await Get.find<SalesOrderRepository>().salesOrder(salesOrderModel);
    if (salesOrderResponse.hasData) {
      salesOrderResponseList = salesOrderResponse.data;
      showSuccessToast(salesOrderResponseList!.msg.toString());
      Get.toNamed(Routes.salesTableReceipt,
          arguments: [salesOrderResponseList!]);
      update();
    } else {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(salesOrderResponse.error));
    }
  }

  ApiResponse _salesOrderUpdateResponse = ApiResponse();

  set salesOrderUpdateResponse(ApiResponse response) {
    _salesOrderUpdateResponse = response;
    update();
  }

  ApiResponse get salesOrderUpdateResponse => _salesOrderUpdateResponse;
  salesOrderUpdate(SalesOrderRequestModel salesOrderModel, int id,
      BuildContext context) async {
    salesOrderUpdateResponse = await Get.find<SalesOrderRepository>()
        .salesOrderUpdate(salesOrderModel, id);

    if (salesOrderUpdateResponse.hasData) {
      showSuccessToast(salesOrderUpdateResponse.data.toString());
      final formattedDate = DateTime.now().toString();
      final time = formattedDate.split(' ')[0];
      Get.put(SalesOrderListController())
          .getsalesOrderList(SalesListRequestParams(
        created_at: time,
      ));

      update();
    }
    // else {
    //   AppSnackbar.showError(
    //       context: context,
    //       message:
    //           NetworkException.getErrorMessage(salesOrderUpdateResponse.error));
    // }
  }

  @override
  void onInit() {
    getcustomerList();
    super.onInit();
  }

  Future<void> printTest(Data salesOrderList) async {
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    if (conexionStatus) {
      List<int> ticket = await testTicket(salesOrderList);
      final result = await PrintBluetoothThermal.writeBytes(ticket);
      print("impresion $result");
      if (result == true) {
        Get.toNamed(Routes.dashboard);
      }
    } else {
      showErrorToast("Printer not connected");

      //no conectado, reconecte
    }
  }

  Future<List<int>> testTicket(Data salesOrderList) async {
    // salesOrderList? salesOrderList =;
    DateTime time = DateTime.now();
    final formattedTime = DateFormat('MMMM d, yyyy, h:mm a').format(time);

    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.reset();

    bytes += generator.text('Hamro Khata Pvt. Ltd.',
        styles: PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text('Pan No.: 0010231001',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Kathmandu, Nepal',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Tel: 01-4444444',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Order No.: ${salesOrderList.invoiceNumber}',
        styles: PosStyles(align: PosAlign.center));

    bytes += generator.text('Date: ${formattedTime}',
        styles: PosStyles(align: PosAlign.center));

    bytes += generator.text('--------------------------------',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.row([
      PosColumn(
        text: 'Name',
        width: 3,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: 'Unit P.',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'Qty',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'Total',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);
    bytes += generator.text('--------------------------------',
        styles: PosStyles(align: PosAlign.center));

    for (var i = 0; i < salesOrderList.salesItems!.length; i++) {
      bytes += generator.row([
        PosColumn(
          text: salesOrderList.salesItems![i].productName.toString(),
          width: 4,
          styles: PosStyles(align: PosAlign.left, underline: true),
        ),
        PosColumn(
          text: salesOrderList.salesItems![i].sellingPrice.toString(),
          width: 3,
          styles: PosStyles(align: PosAlign.center, underline: true),
        ),
        PosColumn(
          text: salesOrderList.salesItems![i].quantity.toString(),
          width: 1,
          styles: PosStyles(align: PosAlign.center, underline: true),
        ),
        PosColumn(
          text: salesOrderList.salesItems![i].total.toString(),
          width: 4,
          styles: PosStyles(align: PosAlign.right, underline: true),
        ),
      ]);
    }
    bytes += generator.text('--------------------------------',
        styles: PosStyles(align: PosAlign.center));

    bytes += generator.row([
      PosColumn(
        text: "",
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: "Sub Total",
        width: 5,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: salesOrderList.subTotal.toString(),
        width: 4,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: "",
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: "Discount",
        width: 5,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: salesOrderList.discountAmount.toString(),
        width: 4,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: "",
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: "13% Tax",
        width: 5,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: salesOrderList.taxAmount.toString(),
        width: 4,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: "",
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: "Grand Total",
        width: 5,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: salesOrderList.grandTotal.toString(),
        width: 4,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    // bytes += generator.text('Keep this receipt for future reference',
    //     styles: PosStyles(align: PosAlign.center));
    // bytes += generator.text('Grand Total price including 13% VAT',
    //     styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('---*---*---*---',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text(
        'Thank you for shopping with us. Please visit again!',
        styles: PosStyles(align: PosAlign.center));

    bytes += generator.feed(1);

    // bytes += generator.cut();
    return bytes;
  }
}
