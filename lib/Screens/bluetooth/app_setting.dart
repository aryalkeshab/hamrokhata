import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/bluetooth/app_setting_controller.dart';
import 'package:hamrokhata/Screens/bluetooth/bluetooth_device_list_screen.dart';
import 'package:hamrokhata/Screens/bluetooth/print_utils.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({super.key});

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  String? bluetoothDevice = '';
  String? printerAddress = '';
  final secureStorage = Get.find<FlutterSecureStorage>();

  @override
  void initState() {
    getPrinterAddress();

    super.initState();
  }

  void getPrinterAddress() async {
    printerAddress =
        await secureStorage.read(key: StorageConstants.printerAddress);

    print(printerAddress);
  }

  @override
  Widget build(BuildContext context) {
    // String   finalBluetoothAddress =
    //     await secureStorage.read(key: StorageConstants.printerAddress);
    Get.put(AppSettingController());
    // bluetoothDevice = SpUtil.getString(Constants.print_mode);
    return GetBuilder<AppSettingController>(
      builder: (appController) {
        return Scaffold(
          appBar: AppBar(title: const Text('App Setting')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Printer Setting",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Divider(
                  height: 2,
                ),
                ModeItemWidget(
                    title: "Bluetooth",
                    subtitle: printerAddress == "" || printerAddress == null
                        ? "Please Select Printer"
                        : printerAddress!,
                    onTest: () {
                      if (printerAddress == "" || printerAddress == null) {
                        showErrorToast("Please configure printer first");
                      } else {
                        //   var buffer1 = StringBuffer();

                        //   buffer1.write("! 0 200 200 200 1\r\n");
                        //   buffer1.write("CENTER\r\n");
                        //   buffer1.write("BARCODE-TEXT 7 0 5\r\n");
                        //   buffer1.write("BARCODE 128 1 1 50 0 10 " + "\r\n");

                        //   buffer1.write("BARCODE-TEXT OFF\r\n");
                        //   buffer1.write("PRINT\r\n");

                        //   String id = "1";
                        //   String productName =
                        //       "Product 1 Waste colllection money";
                        //   String price = "Rs 100000.00";
                        //   String receiptLine =
                        //       "$id   $productName   ${price.padRight(10)}\n";
                        //   String receiptLine2 =
                        //       "${id.padLeft(1)} ${productName} ${price.padRight(10, "c")}\n";
                        //   String text1 = buffer1.toString();

                        PrintUtils.instance
                            .bluetoothPrint(printerAddress!, "sa");
                      }
                      // FlutterBluetoothPrinter.printBytes(
                      //     address: "EC:51:BC:E1:FB:FA",
                      //     data: utf8.encode("Hello") as Uint8List);
                    },
                    onText: () {
                      Get.toNamed(Routes.bluetoothDeviceScreen);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ModeItemWidget extends StatelessWidget {
  const ModeItemWidget({
    Key? key,
    required this.onTest,
    required this.onText,
    required this.title,
    this.isSelected = false,
    required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final VoidCallback onTest;
  final VoidCallback onText;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: isSelected ? Colors.amber : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onText,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 16),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:
                          Text(subtitle, style: const TextStyle(fontSize: 12)))
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onTest,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              color: Colors.grey,
              child: const Text(
                "Test Print",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
