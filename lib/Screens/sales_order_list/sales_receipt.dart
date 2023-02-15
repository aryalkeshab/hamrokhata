import 'package:flutter/material.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list.dart';
import 'package:hamrokhata/Screens/sales_order_list/sakes_order_list_model.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:number_to_character/number_to_character.dart';

class TableForSalesReceipt extends StatefulWidget {
  // final PurchaseItems purchaseItems;
  final List<SalesOrderListResponse>? salesOrderListResponse;
  // final List<PurchaseOrderList>? purchaseOrderList;

  const TableForSalesReceipt({super.key, this.salesOrderListResponse});

  @override
  State<TableForSalesReceipt> createState() => _TableForSalesReceiptState();
}

class _TableForSalesReceiptState extends State<TableForSalesReceipt> {
  var converter = NumberToCharacterConverter('en');

  int qtyExpanded = 2;
  int snExpanded = 1;
  int nameExpanded = 3;
  int unitExpanded = 2;
  int totalExpanded = 3;

  @override
  Widget build(BuildContext context) {
    SalesOrderListResponse? salesOrderListResponse =
        widget.salesOrderListResponse![0];

    return Scaffold(
      appBar: AppBar(
        title: Text(salesOrderListResponse.invoiceNumber!),
      ),
      body: BaseWidget(
        builder: (context, config, theme) {
          salesOrderListResponse.salesItems!.forEach((element) {
            print(element.product);
          });
          return Padding(
            padding: const EdgeInsets.all(12.0),
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
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            salesOrderListResponse.invoiceNumber!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                              salesOrderListResponse.createdAt!
                                      .substring(0, 10) ??
                                  '',
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    )
                  ],
                ),
                config.verticalSpaceSmall(),
                Row(
                  children: [
                    Expanded(
                      flex: snExpanded,
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            "S.N",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                      flex: nameExpanded,
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            "Product Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                      flex: qtyExpanded,
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            "Qty",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Expanded(
                      flex: unitExpanded,
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            "Unit Price",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                      flex: totalExpanded,
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Total",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: salesOrderListResponse.salesItems!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final SalesItems salesItems =
                          salesOrderListResponse.salesItems![index];
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
                                    border: Border.all(color: Colors.black)),
                                child: Text(
                                  "${index + 1}".toString(),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          Expanded(
                            flex: nameExpanded,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Text(
                                  salesItems.productName!.toString(),
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
                                    border: Border.all(color: Colors.black)),
                                child: Text(
                                  salesItems.quantity.toString(),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          Expanded(
                            flex: unitExpanded,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Text(
                                  salesItems.sellingPrice.toString(),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          Expanded(
                            flex: totalExpanded,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Text(
                                    textAlign: TextAlign.right,
                                    salesItems.total!.toString())),
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
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            "TOTAL",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                              textAlign: TextAlign.right,
                              salesOrderListResponse.subTotal.toString())),
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
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            "Discount",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                              textAlign: TextAlign.right,
                              salesOrderListResponse.discountAmount
                                  .toString())),
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
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            "Tax",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                              textAlign: TextAlign.right,
                              salesOrderListResponse.taxAmount.toString())),
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
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            "Grand T.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            textAlign: TextAlign.right,
                            salesOrderListResponse.grandTotal.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
                config.verticalSpaceMedium(),
                Row(
                  children: [
                    Text(
                      "Grand Total in Words: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Text(
                        converter.convertInt(
                            salesOrderListResponse.grandTotal!.toInt()),
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
          );
        },
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(label: "Print Receipt", onPressed: () {}),
        ],
      ),
    );
  }
}