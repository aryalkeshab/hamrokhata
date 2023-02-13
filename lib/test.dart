import 'package:flutter/material.dart';
import 'package:hamrokhata/models/request/purchase_request_model.dart';

class TableForReceipt extends StatefulWidget {
  final PurchaseItems purchaseItems;
  const TableForReceipt({super.key, required this.purchaseItems});

  @override
  State<TableForReceipt> createState() => _TableForReceiptState();
}

class _TableForReceiptState extends State<TableForReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("hello"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text("S.N")),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text("Product Name")),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text("Qty")),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text("Unit Price")),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text("Total")),
                  ),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        // Container(
                        //   decoration: BoxDecoration(
                        //       border: Border.all(color: Colors.black)),
                        //   child:
                        Expanded(
                          flex: 1,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Text("S.N")),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Text("S.N")),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Text("S.N")),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Text("S.N")),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Text("S.N")),
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
                        child: Text("TOTAL")),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text("1000")),
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
                        child: Text("Discount")),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text("100")),
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
                        child: Text("Tax")),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text("1000")),
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
                        child: Text("Grand T.")),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text("1000.00")),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
