import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

class PrintUtils {
  PrintUtils._();
  static final PrintUtils _instance = PrintUtils._();
  static PrintUtils get instance => _instance;

  Future bluetoothPrint(String address, String text) async {
    try {
      await FlutterBluetoothPrinter.printBytes(
          keepConnected: true,
          address: address,
          data: utf8.encode(text) as Uint8List);
    } catch (e) {
      showErrorToast("Error Printing");
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future posbluetoothPrint(String address, String text) async {
    try {
      await FlutterBluetoothPrinter.printBytes(
          keepConnected: true,
          address: address,
          data: utf8.encode(text) as Uint8List);
    } catch (e) {
      showErrorToast("Error Printing");
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
