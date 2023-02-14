import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/bluetooth/app_setting_controller.dart';
import 'package:hamrokhata/commons/widgets/buttons/primary_btn_widget.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

class BluetoothDeviceScreen extends HookWidget {
  const BluetoothDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppSettingController());
    return GetBuilder<AppSettingController>(builder: (appController) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Select Bluetooth Printer"),
        ),
        body: StreamBuilder(
            stream: FlutterBluetoothPrinter.discovery,
            builder: (context, snapshot) {
              if (snapshot.data is BluetoothDisabledState) {
                return const BluetoothOffScreen();
              } else {
                final List list;
                if (snapshot.data != null) {
                  list = (snapshot.data as DiscoveryResult).devices;
                } else {
                  list = [];
                }
                return Visibility(
                  visible: list.isNotEmpty,
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                appController.saveBlutoothPrinterDetails(
                                    list[index].address);
                                Get.back();
                              },
                              title: Text(list[index].name ?? ""),
                              subtitle: Text(list[index].address.toString()),
                              leading: const Icon(Icons.bluetooth),
                            )
                          ],
                        );
                      }),
                );
              }
            }),
      );
    });
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          "assets/images/bluetooth.png",
          height: 200,
          width: 200,
        ),
        const Text(
          "Oops!! Seems like Bluetooth is turned off",
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: PrimaryBtnWidget(
              title: "Turn on Bluetooth",
              onPressed: () {
                BluetoothEnable.enableBluetooth.then((result) {
                  if (result == "true") {
                    // Bluetooth has been enabled
                  } else if (result == "false") {
                    showErrorToast("Bluetooth must be turned on");
                  }
                });
              }),
        )
      ],
    );
  }
}
