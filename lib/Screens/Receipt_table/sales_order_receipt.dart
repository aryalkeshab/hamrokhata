import 'package:flutter/material.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/models/request/sales_response_model.dart';
import 'package:hamrokhata/models/response/purchase_order_response_model.dart';
import 'package:number_to_character/number_to_character.dart';

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

  @override
  Widget build(BuildContext context) {
    SalesOrderResponse? salesOrderResponse = widget.salesOrderResponse[0];
    final data = salesOrderResponse.data;

    return Scaffold(
      appBar: AppBar(
        title: Text(data!.invoiceNumber!),
      ),
      body: BaseWidget(
        builder: (context, config, theme) {
          data.salesItems!.forEach((element) {
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
                            data.invoiceNumber!,
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
                          Text(data.createdAt!.substring(0, 10) ?? '',
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
                    itemCount: data.salesItems!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final SalesItems purchaseItems = data.salesItems![index];
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
                                  purchaseItems.productName!.toString(),
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
                                  purchaseItems.quantity.toString(),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          Expanded(
                            flex: unitExpanded,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Text(
                                  purchaseItems.sellingPrice.toString(),
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
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            "Sub T.",
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              double.parse(data.discountAmount.toString())
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
                            double.parse(data.grandTotal.toString())
                                .toStringAsFixed(2),
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
                        converter.convertInt(data.grandTotal!.toInt()),
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
