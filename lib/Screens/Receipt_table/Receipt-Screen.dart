import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/bluetooth/print_utils.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_controller.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list.dart';
import 'package:hamrokhata/Screens/sales_order_list/sakes_order_list_model.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/models/vendor_list.dart';
import 'package:number_to_character/number_to_character.dart';

class TableForReceipt extends StatefulWidget {
  // final PurchaseItems purchaseItems;
  // final SalesOrderListResponse? salesOrderListResponse;
  final List<PurchaseOrderList>? purchaseOrderList;

  const TableForReceipt({super.key, this.purchaseOrderList});

  @override
  State<TableForReceipt> createState() => _TableForReceiptState();
}

class _TableForReceiptState extends State<TableForReceipt> {
  var converter = NumberToCharacterConverter('en');
  final secureStorage = Get.find<FlutterSecureStorage>();

  int qtyExpanded = 2;
  int snExpanded = 1;
  int nameExpanded = 3;
  int unitExpanded = 2;
  int totalExpanded = 3;
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
    PurchaseOrderList? purchaseOrderList = widget.purchaseOrderList![0];

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(child: Text(purchaseOrderList.billNumber!)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.dashboard);
          },
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 2.0,
        ),
      ),
      body: BaseWidget(
        builder: (context, config, theme) {
          purchaseOrderList.purchaseItems!.forEach((element) {
            print(element.product);
          });
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: config.appHorizontalPaddingSmall()),
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    color: purchaseOrderList.status == "Failed"
                        ? Colors.red[100]
                        : purchaseOrderList.status == "Completed"
                            ? Colors.green[100]
                            : Colors.yellow[100],
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Text(
                            "Hamro Khata Pvt. Ltd.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Pan No: 60100030100",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          config.verticalSpaceSmall(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "Bill No: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      purchaseOrderList.billNumber!,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Date: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                        purchaseOrderList.createdAt!
                                            .substring(0, 10),
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Builder(builder: (context) {
                            int vendorId = int.parse(purchaseOrderList.vendor!
                                // .name
                                .toString());
                            List<VendorList> vendorList =
                                Get.find<PurchaseOrderController>()
                                    .vendorApiResult;
                            String vendorName = vendorList
                                .firstWhere((element) => element.id == vendorId)
                                .name!;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Vendor Name: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        vendorName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                // Expanded(
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       Text(
                                //         "Order Status: ",
                                //         style: TextStyle(
                                //             fontWeight: FontWeight.bold, fontSize: 18),
                                //       ),
                                //       Text(data.status!.toString(),
                                //           softWrap: false,
                                //           overflow: TextOverflow.ellipsis,
                                //           maxLines: 1,
                                //           style: TextStyle(fontSize: 18)),
                                //     ],
                                //   ),
                                // )
                              ],
                            );
                          }),
                          config.verticalSpaceSmall(),
                          Row(
                            children: [
                              Expanded(
                                flex: snExpanded,
                                child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "S.N",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Expanded(
                                flex: nameExpanded,
                                child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "Product Name",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Expanded(
                                flex: qtyExpanded,
                                child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "Qty",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              Expanded(
                                flex: unitExpanded,
                                child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "Unit Price",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Expanded(
                                flex: totalExpanded,
                                child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Total",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  purchaseOrderList.purchaseItems!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final PurchaseItems purchaseItems =
                                    purchaseOrderList.purchaseItems![index];
                                return Row(
                                  children: [
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       border: Border.all(color: Colors.black)),
                                    //   child:
                                    Expanded(
                                      flex: snExpanded,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Text(
                                            "${index + 1}".toString(),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                    Expanded(
                                      flex: nameExpanded,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Text(
                                            purchaseItems.productName!
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                    Expanded(
                                      flex: qtyExpanded,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Text(
                                            purchaseItems.quantity.toString(),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                    Expanded(
                                      flex: unitExpanded,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Text(
                                            purchaseItems.purchasePrice
                                                .toString(),
                                            textAlign: TextAlign.right,
                                          )),
                                    ),
                                    Expanded(
                                      flex: totalExpanded,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Text(
                                              textAlign: TextAlign.right,
                                              purchaseItems.total!.toString())),
                                    ),
                                  ],
                                );
                              }),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.black)),
                                    child: Text("")),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.black)),
                                    child: Text("")),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(child: Text("")),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "Sub T.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        double.parse(purchaseOrderList.subTotal
                                                .toString())
                                            .toStringAsFixed(2))),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.black)),
                                    child: Text("")),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.black)),
                                    child: Text("")),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(child: Text("")),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "Discount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                        textAlign: TextAlign.right,
                                        double.parse(purchaseOrderList
                                                .discountAmount
                                                .toString())
                                            .toStringAsFixed(2))),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.black)),
                                    child: Text("")),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.black)),
                                    child: Text("")),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(child: Text("")),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "Tax",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                        textAlign: TextAlign.right,
                                        double.parse(purchaseOrderList.taxAmount
                                                .toString())
                                            .toStringAsFixed(1))),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.black)),
                                    child: Text("")),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.black)),
                                    child: Text("")),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(child: Text("")),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "Grand T.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      textAlign: TextAlign.right,
                                      double.parse(purchaseOrderList.grandTotal
                                              .toString())
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          config.verticalSpaceMedium(),
                          Row(
                            children: [
                              Text(
                                "Grand Total in Words: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  converter.convertInt(
                                      purchaseOrderList.grandTotal!.toInt()),
                                  maxLines: 2,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                  // new
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Staff : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Expanded(
                                child: Text(
                                  purchaseOrderList.purchaseByName.toString(),

                                  // converter.convertInt(data.grandTotal!.toInt()),
                                  maxLines: 2,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                  // new
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(""),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          purchaseOrderList.status == "Completed"
              ? PrimaryButton(
                  label: "Print Receipt",
                  onPressed: () {
                    // printInventoryReceipt();
                    print(printerAddress);
                    var buffer1 = StringBuffer();
                    buffer1.write("Purchase Order Receipt");
                    buffer1.write("\n");
                    buffer1.write("BlueBird Inventory System");
                    buffer1.write("\n");
                    buffer1.write("Pan No: 123456789");
                    buffer1.write("\n");
                    buffer1.write("Pokhara-17, Birauta");
                    buffer1.write("\n");
                    buffer1.write("Phone: 9841234567");
                    buffer1.write("\n");

                    // buffer1.write("Purchase Order No: " +
                    //     purchaseOrderList[].toString());

                    buffer1.write("Name" + " " + "Qty" + " " + "Total");
                    buffer1.write("\n");

                    for (int i = 0;
                        i <= purchaseOrderList.purchaseItems!.length - 1;
                        i++) {
                      buffer1.write(purchaseOrderList
                              .purchaseItems![i]!.productName
                              .toString() +
                          " " +
                          purchaseOrderList.purchaseItems![i].quantity
                              .toString() +
                          " " +
                          purchaseOrderList.purchaseItems![i].total.toString());
                      buffer1.write("\n");
                    }
                    buffer1.write("\n");
                    buffer1.write("\n");

                    PrintUtils.instance
                        .bluetoothPrint(printerAddress!, buffer1.toString());
                  })
              : SizedBox(),
        ],
      ),
    );
  }
}
