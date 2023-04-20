import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/Screens/bluetooth/print_utils.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';

import 'package:hamrokhata/commons/resources/confirm_dialog_view.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/dashboard_module.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final secureStorage = Get.find<FlutterSecureStorage>();
  String? printerAddress;

  @override
  void initState() {
    getPrinterAddress();
    super.initState();
  }

  void getPrinterAddress() async {
    printerAddress =
        await secureStorage.read(key: StorageConstants.printerAddress);
  }

  @override
  Widget build(BuildContext context) {
    print(printerAddress);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text("Keshab")),
              PopupMenuItem(
                child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmDialogView(
                            primaryText: "Are you sure want to logout?",
                            onApproveButtonPressed: () {
                              Get.find<AuthController>().logout();
                            },
                            onCancelButtonPressed: Get.back,
                          );
                        },
                      );
                    },
                    child: const Text("Logout")

                    //  const Icon(
                    //   Icons.logout,
                    //   color: Colors.black,
                    // ),
                    ),
              ),
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.changePasswordScreeen);
                    Navigator.pop(context);
                  },
                  child: const Text("Change Password"),
                ),
              ),
            ],
          ),
          // AuthWidgetBuilder(builder: (context, isAuthenticated) {
          //   return IconButton(
          //     onPressed: () {
          //       showDialog(
          //         context: context,
          //         builder: (context) {
          //           return ConfirmDialogView(
          //             primaryText: "Are you sure want to logout?",
          //             onApproveButtonPressed: () {
          //               Get.find<AuthController>().logout();
          //             },
          //             onCancelButtonPressed: Get.back,
          //           );
          //         },
          //       );
          //     },
          //     icon: const Icon(Icons.logout_rounded),
          //   );
          // }),
        ],
      ),
      body: BaseWidget(
        builder: (context, config, theme) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: config.appHorizontalPaddingLarge(),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/app_logo.png"),
                    ),
                    config.verticalSpaceMedium(),
                    GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        padding: const EdgeInsets.all(8.0),
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 2.0,
                        children: [
                          DashboardModule(
                            text: 'Product Details',
                            onPressed: () {
                              Get.toNamed(Routes.productDetails);
                            },
                            icons: Icons.price_check_rounded,
                          ),
                          DashboardModule(
                            text: 'Add Products',
                            onPressed: () {
                              Get.toNamed(Routes.addProductScreen);
                            },
                            icons: Icons.production_quantity_limits_sharp,
                          ),
                          DashboardModule(
                            text: 'Purchase Order',
                            onPressed: () {
                              Get.toNamed(Routes.purchaseOrder);
                            },
                            icons: Icons.add_circle_rounded,
                          ),
                          DashboardModule(
                            text: 'Purchase Order List',
                            onPressed: () {
                              Get.toNamed(Routes.purchaseOrderList);
                              // printInventoryReceipt();
                              // print(printerAddress);
                              // var buffer1 = StringBuffer();
                              // buffer1.write("Purchase Order Receipt");
                              // buffer1.write("\n");
                              // buffer1.write("BlueBird Inventory System");
                              // buffer1.write("\n");
                              // buffer1.write("Pan No: 123456789");
                              // buffer1.write("\n");
                              // buffer1.write("Pokhara-17, Birauta");
                              // buffer1.write("\n");
                              // buffer1.write("Phone: 9841234567");
                              // buffer1.write("\n");
                              // buffer1.write("\n");
                              // buffer1.write("\n");
                              // buffer1.write("\n");
                              // buffer1.write("\n");
                              // buffer1.write("\n");

                              // PrintUtils.instance.bluetoothPrint(
                              //     printerAddress!, buffer1.toString());
                            },
                            icons: Icons.microwave_rounded,
                          ),
                          DashboardModule(
                            text: 'Sales Order',
                            onPressed: () {
                              Get.toNamed(Routes.salesOrder);
                            },
                            icons: Icons.add_circle_rounded,
                          ),
                          DashboardModule(
                            text: 'Sales Order List',
                            onPressed: () {
                              Get.toNamed(Routes.salesOrderList);
                            },
                            icons: Icons.account_box,
                          ),
                          DashboardModule(
                            text: 'Print Setting',
                            onPressed: () {
                              Get.toNamed(Routes.appSetting);
                            },
                            icons: Icons.print,
                          ),
                          // DashboardModule(
                          //   text: 'Change Password',
                          //   onPressed: () {
                          //     Get.toNamed(Routes.changePasswordScreeen);
                          //   },
                          //   icons: Icons.password,
                          // ),
                        ]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

//   void printInventoryReceipt(PurchaseOrderResponse purchaseOrder) async {
//     // Get the Bluetooth printer device address
//     String printerAddress = await FlutterBluetoothPrinter.currentPrinterAddress;

// //     // Define the company information and invoice details
//     String companyName = "My Company Name";
//     String companyAddress = "123 Main Street, Anytown, USA";
//     String invoiceNumber = purchaseOrder.billNumber ?? "";
//     String invoiceDate = purchaseOrder.createdAt ?? "";
//     double subTotal = purchaseOrder.subTotal ?? 0.0;
//     double discountAmount = purchaseOrder.discountAmount ?? 0.0;
//     double taxAmount = purchaseOrder.taxAmount ?? 0.0;
//     double grandTotal = purchaseOrder.grandTotal ?? 0.0;

//     // Define the list of items in the inventory
//     List<Map<String, dynamic>> inventoryItems = [];
//     for (var item in purchaseOrder.purchaseItems ?? []) {
//       inventoryItems.add({
//         "name": item.productName ?? "",
//         "quantity": item.quantity ?? 0,
//         "price": item.purchasePrice ?? "",
//         "total": item.total ?? 0.0,
//       });
//     }

//     // Create the receipt text
//     String receiptText = """
// $companyName
// $companyAddress

// Invoice Number: $invoiceNumber
// Date: $invoiceDate

// Items:
// """;
//     for (var item in inventoryItems) {
//       receiptText +=
//           "${item['name']} - ${item['quantity']} x ${item['price']} = ${item['total']}\n";
//     }
//     receiptText += """
// ------------------------

// Sub Total: ${subTotal.toStringAsFixed(2).padLeft(30)}
// Discount: ${discountAmount.toStringAsFixed(2).padLeft(30)}
// Tax: ${taxAmount.toStringAsFixed(2).padLeft(30)}
// ------------------------
// Grand Total: ${grandTotal.toStringAsFixed(2).padLeft(30)}
// """;

//     // Print the receipt to the Bluetooth printer
//     bool isConnected = await FlutterBluetoothPrinter.connect(printerAddress);
//     if (isConnected) {
//       await FlutterBluetoothPrinter.printReceipt(receiptText);
//       FlutterBluetoothPrinter.disconnect();
//     }
//   }

  void printInventoryReceipt() async {
    // Get the Bluetooth printer device address
    // String printerAddress = await FlutterBluetoothPrinter.currentPrinterAddress;

    // Define the company information and invoice details
//     String companyName = "My Company Name";
//     String companyAddress = "123 Main Street, Anytown, USA";
//     String invoiceNumber = "INV-001";
//     String invoiceDate = "2023-04-15";
//     double totalAmount = 1000.0;
//     double discountAmount = 100.0;
//     double vatAmount = 150.0;

//     // Define the list of items in the inventory
    List<Map<String, dynamic>> inventoryItems = [
      {
        "name": "Item 1",
        "quantity": 2,
        "price": 250.0,
        "total": 500.0,
      },
      {
        "name": "Item 2",
        "quantity": 1,
        "price": 300.0,
        "total": 300.0,
      },
      {
        "name": "Item 3",
        "quantity": 3,
        "price": 150.0,
        "total": 450.0,
      },
    ];

//     // Create the receipt text
//     String receiptText = """
// $companyName
// $companyAddress

// Invoice Number: $invoiceNumber
// Date: $invoiceDate

// Items:
// ------------------------
// """;
//     for (var item in inventoryItems) {
//       receiptText +=
//           "${item['name']} - ${item['quantity']} x ${item['price']} = ${item['total']}\n";
//     }
//     receiptText += """
// ------------------------

// Total Amount: $totalAmount
// Discount: $discountAmount
// VAT: $vatAmount

// Grand Total: ${totalAmount - discountAmount + vatAmount}
// """;
    // Define the company information and invoice details
    String companyName = "My Company Name";
    String companyAddress = "123 Main Street, Anytown, USA";
    String invoiceNumber = "21312" ?? "";
    String invoiceDate = "asda" ?? "";
    double subTotal = 2.2 ?? 0.0;
    double discountAmount = 2.2 ?? 0.0;
    double taxAmount = 2.2 ?? 0.0;
    double grandTotal = 2.2 ?? 0.0;

    // Define the list of items in the inventory
    // List<Map<String, dynamic>> inventoryItems = [];
    // for (var item in purchaseOrder.purchaseItems ?? []) {
    //   inventoryItems.add({
    //     "name": item.productName ?? "",
    //     "quantity": item.quantity ?? 0,
    //     "price": item.purchasePrice ?? "",
    //     "total": item.total ?? 0.0,
    //   });
    // }

    // Create the receipt text
    String receiptText = """
$companyName
$companyAddress

Invoice Number: $invoiceNumber
Date: $invoiceDate

Items:
""";
    for (var item in inventoryItems) {
      receiptText +=
          "${item['name']} - ${item['quantity']} x ${item['price']} = ${item['total']}\n";
    }
    receiptText += """
------------------------

Sub Total: ${subTotal.toStringAsFixed(2).padLeft(30)}
Discount: ${discountAmount.toStringAsFixed(2).padLeft(30)}
Tax: ${taxAmount.toStringAsFixed(2).padLeft(30)}
------------------------
Grand Total: ${grandTotal.toStringAsFixed(2).padLeft(30)}
""";

    // Print the receipt to the Bluetooth printer
    // bool isConnected = await FlutterBluetoothPrinter.connect(printerAddress);
    // if (isConnected) {
    //   await FlutterBluetoothPrinter.printReceipt(receiptText);
    //   FlutterBluetoothPrinter.disconnect();
    // }
    PrintUtils.instance.bluetoothPrint(printerAddress!, receiptText);
  }
}

// void printInventoryReceipt(PurchaseOrderResponse purchaseOrder) async {
//   // Get the Bluetooth printer device address
//   String printerAddress = await FlutterBluetoothPrinter.currentPrinterAddress;

//   // Define the company information and invoice details
//   String companyName = "My Company Name";
//   String companyAddress = "123 Main Street, Anytown, USA";
//   String invoiceNumber = purchaseOrder.billNumber ?? "";
//   String invoiceDate = purchaseOrder.createdAt ?? "";
//   double subTotal = purchaseOrder.subTotal ?? 0.0;
//   double discountAmount = purchaseOrder.discountAmount ?? 0.0;
//   double taxAmount = purchaseOrder.taxAmount ?? 0.0;
//   double grandTotal = purchaseOrder.grandTotal ?? 0.0;

//   // Define the list of items in the inventory
//   List<Map<String, dynamic>> inventoryItems = [];
//   for (var item in purchaseOrder.purchaseItems ?? []) {
//     inventoryItems.add({
//       "name": item.productName ?? "",
//       "quantity": item.quantity ?? 0,
//       "price": item.purchasePrice ?? "",
//       "total": item.total ?? 0.0,
//     });
//   }

//   // Create the receipt text
//   String receiptText = """
// $companyName
// $companyAddress

// Invoice Number: $invoiceNumber
// Date: $invoiceDate

// Items:
// """;
//   for (var item in inventoryItems) {
//     receiptText +=
//         "${item['name']} - ${item['quantity']} x ${item['price']} = ${item['total']}\n";
//   }
//   receiptText += """
// ------------------------

// Sub Total: ${subTotal.toStringAsFixed(2).padLeft(30)}
// Discount: ${discountAmount.toStringAsFixed(2).padLeft(30)}
// Tax: ${taxAmount.toStringAsFixed(2).padLeft(30)}
// ------------------------
// Grand Total: ${grandTotal.toStringAsFixed(2).padLeft(30)}
// """;

//   // Print the receipt to the Bluetooth printer
//   bool isConnected = await FlutterBluetoothPrinter.connect(printerAddress);
//   if (isConnected) {
//     await FlutterBluetoothPrinter.printReceipt(receiptText);
//     FlutterBluetoothPrinter.disconnect();
//   }
// }
