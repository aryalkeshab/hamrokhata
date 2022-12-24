import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

class Scanqr {
  Scanqr._();
  static Future<String> barcodeScanner(BuildContext context) async {
    try {
      ScanResult qrResult = await BarcodeScanner.scan();

      return qrResult.rawContent;
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        showErrorToast(
          "Camera permission was denied",
        );
      } else {
        showErrorToast("Unknown Error $ex");
      }
      rethrow;
    } on FormatException {
      showErrorToast(
        "You pressed the back button before scanning anything",
      );
      rethrow;
    } catch (ex) {
      showErrorToast(
        "You pressed the back button before scanning anything",
      );
      rethrow;
    }
  }
}
