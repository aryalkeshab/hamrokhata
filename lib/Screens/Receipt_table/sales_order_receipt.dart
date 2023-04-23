import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/models/customer_model.dart';
import 'package:hamrokhata/models/response/sales_response_model.dart';
import 'package:hamrokhata/models/response/purchase_order_response_model.dart';
import 'package:number_to_character/number_to_character.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../commons/api/storage_constants.dart';

class SalesOrderReceipt extends StatefulWidget {
  // final PurchaseItems purchaseItems;
  // final SalesOrderListResponse? salesOrderListResponse;
  final List<SalesOrderResponse> salesOrderResponse;

  const SalesOrderReceipt({super.key, required this.salesOrderResponse});

  @override
  State<SalesOrderReceipt> createState() => _SalesOrderReceiptState();
}

class _SalesOrderReceiptState extends State<SalesOrderReceipt> {
  var converter = NumberToCharacterConverter('en');

  int qtyExpanded = 2;
  int snExpanded = 1;
  int nameExpanded = 3;
  int unitExpanded = 2;
  int totalExpanded = 3;
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
    SalesOrderResponse? salesOrderResponse = widget.salesOrderResponse[0];
    final data = salesOrderResponse.data;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text(data!.invoiceNumber!)),
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
          data.salesItems!.forEach((element) {
            print(element.product);
          });
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: config.appHorizontalPaddingSmall()),
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    color: salesOrderResponse.data!.salesStatus == "Failed"
                        ? Colors.red[100]
                        : salesOrderResponse.data!.salesStatus == "Completed"
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
                            "Pan No: 601000000",
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
                                      data.invoiceNumber!,
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
                                    Text(data.createdAt!.substring(0, 10),
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
                            // int vendorId =
                            //     int.parse(data.customer!.name.toString());
                            // List<CustomerModel> customerList =
                            //     Get.find<SalesOrderController>()
                            //         .customerApiResult;
                            // String customerName = customerList
                            //     .firstWhere((element) => element.id == vendorId)
                            //     .name!;
                            String customerName = data.customer!;

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
                                        customerName,
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
                              itemCount: data.salesItems!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final SalesItems purchaseItems =
                                    data.salesItems![index];
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
                                            purchaseItems.sellingPrice
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
                                        double.parse(data.subTotal.toString())
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
                                        double.parse(
                                                data.discountAmount.toString())
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
                                        double.parse(data.taxAmount.toString())
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
                                      double.parse(data.grandTotal.toString())
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
                                  converter
                                      .convertInt(data.grandTotal!.toInt()),
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
                                  data.salesBy.toString(),

                                  // converter.convertInt(data.grandTotal!.toInt()),
                                  maxLines: 2,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                  // new
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          );
        },
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          salesOrderResponse.data!.salesStatus == "Completed"
              ? PrimaryButton(
                  label: "Print Receipt",
                  onPressed: () async {
                    final bool result = await PrintBluetoothThermal.connect(
                        macPrinterAddress: printerAddress!);
                    Get.put(SalesOrderController())
                        .printTest(salesOrderResponse.data!);

                    if (result == true) {
                      // printReceipt();
                      // Get.put(PurchaseOrderListController())
                      //     .printTest(widget.purchaseOrderList![0]);
                    } else {
                      print('please select device');
                    }
                  })
              : SizedBox(),
        ],
      ),
    );
  }
}
