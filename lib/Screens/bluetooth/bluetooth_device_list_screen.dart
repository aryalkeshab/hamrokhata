import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
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
              } else if (snapshot.data is PermissionRestrictedState) {
                return const BluetoothOffScreen();
              } else if (snapshot.data is BluetoothDisabledState) {
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

// class BluetoothDeviceScreen extends StatefulWidget {
//   const BluetoothDeviceScreen({super.key});

//   @override
//   State<BluetoothDeviceScreen> createState() => _BluetoothDeviceScreenState();
// }

// class _BluetoothDeviceScreenState extends State<BluetoothDeviceScreen> {
//   PrinterBluetooth? printer;
//   @override
//   Widget build(BuildContext context) {
//     PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
//     List<PrinterBluetooth>? _devices = [];
//     String _devicesMsg;
//     BluetoothManager bluetoothManager = BluetoothManager.instance;
//     Get.put(AppSettingController());
//     return GetBuilder<AppSettingController>(builder: (appController) {
//       return Scaffold(
//           appBar: AppBar(
//             title: const Text("Select Bluetooth Printer"),
//           ),
//           body: StreamBuilder(
//             stream: _printerManager.scanResults,
//             builder: (context, snapshot) {
//               _devices = snapshot.data;
//               if (_devices!.isEmpty) {
//                 _devicesMsg = "No devices found";
//               } else {
//                 _devicesMsg = "Devices found";
//               }
//               return Column(
//                 children: [
//                   Text(_devicesMsg),
//                   Expanded(
//                     child: ListView.builder(
//                         itemCount: _devices!.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Column(
//                             children: [
//                               ListTile(
//                                 onTap: () async {
//                                   // appController.saveBlutoothPrinterDetails(
//                                   //     _devices![index].address);
//                                   // Get.back();
//                                   _printerManager
//                                       .selectPrinter(_devices![index]);
//                                   final myTicket =
//                                       await _ticket(PaperSize.mm58);
//                                   final result = await _printerManager
//                                       .printTicket(myTicket);
//                                   print(result);
//                                 },
//                                 title: Text(_devices![index].name ?? ""),
//                                 subtitle:
//                                     Text(_devices![index].address.toString()),
//                                 leading: const Icon(Icons.bluetooth),
//                               )
//                             ],
//                           );
//                         }),
//                   ),
//                 ],
//               );
//             },
//           ));
//     });
//   }

//   Future<Ticket> _ticket(PaperSize paper) async {
//     final ticket = Ticket(paper);
//     ticket.text(widget.orderType);
//     ticket.text(widget.orderNumber);
//     ticket.text(widget.customerName);
//     ticket.text(widget.deliveryTime);
//     ticket.text(widget.instruction);

//     ticket.cut();
//     return ticket;
//   }

//   Widget MyProgressIndicator() {
//     return CircularProgressIndicator();
//   }
// }
