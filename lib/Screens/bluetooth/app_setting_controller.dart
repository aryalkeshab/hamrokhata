import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';

class AppSettingController extends GetxController {
  final secureStorage = Get.find<FlutterSecureStorage>();

  String? finalBluetoothAddress = '';

  void saveBlutoothPrinterDetails(String? bluetoothAddress) async {
    await secureStorage.write(
        key: StorageConstants.printerAddress, value: bluetoothAddress);

    finalBluetoothAddress =
        await secureStorage.read(key: StorageConstants.printerAddress);
    print(finalBluetoothAddress);

    update();
  }
}
