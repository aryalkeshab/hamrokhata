import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:get/get.dart';

import 'package:hamrokhata/Screens/sales_order/sales_order_repository.dart';
import 'package:hamrokhata/commons/api/api_result.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/request/sales_list_request_params.dart';

import 'package:hamrokhata/models/response/sales_order_list.dart';
import 'package:intl/intl.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class SalesOrderListController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //getSalesList
  List<SalesOrderList>? salesOrderResponseList = [];

  ApiResponse _salesOrderResponse = ApiResponse();

  set salesOrderResponse(ApiResponse response) {
    _salesOrderResponse = response;
    update();
  }

  ApiResponse get salesOrderResponse => _salesOrderResponse;

  getsalesOrderList(SalesListRequestParams salesListRequestParams) async {
    salesOrderResponse = await Get.find<SalesOrderRepository>()
        .salesOrderList(salesListRequestParams);
    if (salesOrderResponse.hasData) {
      salesOrderResponseList = salesOrderResponse.data;
      update();
    } else {}
  }

  Future<void> printTest(SalesOrderList salesOrderList) async {
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    if (conexionStatus) {
      List<int> ticket = await testTicket(salesOrderList);
      final result = await PrintBluetoothThermal.writeBytes(ticket);
      print("impresion $result");
      if (result == true) {
        Get.toNamed(Routes.salesOrderList);
      }
    } else {
      showErrorToast("Printer not connected");

      //no conectado, reconecte
    }
  }

  Future<List<int>> testTicket(SalesOrderList salesOrderList) async {
    // salesOrderList? salesOrderList =;
    DateTime time = DateTime.now();
    final formattedTime = DateFormat('MMMM d, yyyy, h:mm a').format(time);

    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.reset();

    bytes += generator.text('Hishab Kitab Pvt. Ltd.',
        styles: PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text('Pan No.: 0010231001',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Kathmandu, Nepal',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Tel: 01-4444444',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Order No.: ${salesOrderList.invoiceNumber}',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Customer Name.: ${salesOrderList.customer}',
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
