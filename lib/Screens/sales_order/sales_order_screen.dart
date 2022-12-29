import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/commons/utils/scanqr.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/dialog/dialog_sales_order.dart';
import 'package:hamrokhata/commons/widgets/dialog/dialog_with_custom_child_and_buttons.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

class SalesOrderScreen extends StatefulWidget {
  const SalesOrderScreen({super.key});

  @override
  State<SalesOrderScreen> createState() => _SalesOrderScreenState();
}

class _SalesOrderScreenState extends State<SalesOrderScreen> {
  int count = 100000;
  String? scannedCode;
  String? qty;
  String? price;
  String? productName;

  TextEditingController searchController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  incrementCounter() {
    setState(() {
      count++;
    });
  }

  List<SalesOrderModel> salesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Sales Order Screen'),
      ),
      body: BaseWidget(builder: (context, config, theme) {
        print(count);
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: config.appVerticalPaddingMedium()),
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: PrimaryButton(
                  label: 'New Order',
                  onPressed: () {
                    dialogWithCustomChildAndTwoButton(
                        context: context,
                        title: 'Do you want to create new sales Order?',
                        acceptFun: () {
                          setState(() {
                            incrementCounter();
                          });
                          showSuccessToast(
                              'New Sales Order $count is created !');
                          Navigator.pop(context);
                        },
                        rejectFun: () {
                          Navigator.pop(context);
                        });
                  }),
            ),
            const Divider(
              height: 2,
            ),
            config.verticalSpaceMedium(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'New Sales Order:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    config.verticalSpaceSmall(),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        count.toString(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
              child: Row(
                children: const [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Product Name ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Qty",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Amount",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
            ),
            Column(
              children: List.generate(
                  salesList.length
                  //trackingList.length
                  , (index) {
                print(salesList);
                SalesOrderModel salesModelList = salesList[index];

                return Visibility(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: InkWell(
                      onTap: () {
                        dialogWithCustomChildAndTwoButton(
                            context: context,
                            title: 'Do you want to Delete the Order?',
                            acceptFun: () {
                              setState(() {
                                salesList.removeAt(index);
                              });
                              showSuccessToast(
                                  'New Sales Order $count is created !');
                              Navigator.pop(context);
                            },
                            rejectFun: () {
                              Navigator.pop(context);
                            });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              salesModelList.productName ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              salesModelList.productQty ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  salesModelList.price ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                PopupMenuButton<int>(
                                    icon: const Icon(Icons.more_vert),
                                    onSelected: (item) =>
                                        selectedItem(context, item, index),
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  dialogWithCustomChildAndTwoButton(
                                                      context: context,
                                                      title:
                                                          'Do you want to Delete the Order?',
                                                      acceptFun: () {
                                                        setState(() {
                                                          salesList
                                                              .removeAt(index);
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        });

                                                        showSuccessToast(
                                                            'New Sales Order $count is created !');
                                                        // Navigator.pop(context);
                                                      },
                                                      rejectFun: () {
                                                        Navigator.pop(context);
                                                      });
                                                });
                                              },
                                              icon: const Icon(Icons.delete),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  customDialog(context, config,
                                                      theme, index);
                                                });
                                              },
                                              icon: const Icon(Icons.edit),
                                            ),
                                          ),
                                        ])
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ]),
        );
      }),
      floatingActionButton: DraggableFab(
        child: BaseWidget(builder: (context, config, theme) {
          return FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 5,
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
            label: const Text(
              'Add lines',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              customDialog(context, config, theme, null);
            },
          );
        }),
      ),
      bottomSheet: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Divider(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  '0.00',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  customDialog(context, config, theme, index) {
    if (index != null) {
      setState(() {
        searchController.text = salesList[index].productName!;
        qtyController.text = salesList[index].productQty!;
        priceController.text = salesList[index].price!;
      });
    } else {
      searchController.clear();
      qtyController.clear();
      priceController.clear();
    }

    return dialogSalesOrderCustom(
        context: (context),
        title: 'Sales Order',
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    PrimaryFormField(
                      controller: searchController,
                      onSaved: (saved) {
                        setState(() {
                          scannedCode = saved;
                        });
                      },
                      hintIcon: IconButton(
                        icon: const Icon(CupertinoIcons.barcode),
                        onPressed: (() async {
                          scannedCode = await Scanqr.barcodeScanner(context);
                          print(scannedCode);
                        }),
                      ),
                      onChanged: (value) {
                        setState(() {
                          scannedCode = value;
                        });
                      },
                      hintTxt: "Item No. ",
                    ),
                  ],
                ),
              ),
              config.horizontalSpaceMedium(),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10.0, top: 10),
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          showSuccessToast(
                              'Successfully search for ${searchController.text}. ');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          config.verticalSpaceMedium(),
          Row(
            children: const [
              Expanded(
                child: Text(
                  "Item No. ",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Product Name",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          // config.verticalSpaceSmall(),
          Row(
            children: const [
              Expanded(
                child: Text(
                  '9006',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Hand Fan',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ],
          ),
          config.verticalSpaceMedium(),
          Row(
            children: const [
              Expanded(
                child: Text(
                  "Price",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Qty to buy",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          // config.verticalSpaceSmall(),
          Row(
            children: [
              Expanded(
                child: PrimaryFormField(
                  controller: priceController,
                  hintTxt: "eg 10 ",
                  onChanged: (value) {
                    setState(() {
                      price = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      price = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: PrimaryFormField(
                    hintTxt: "eg 10 ",
                    controller: qtyController,
                    onChanged: (value) {
                      setState(() {
                        qty = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        qty = value;
                      });
                    }),
              ),
            ],
          ),
          config.verticalSpaceMedium(),
          PrimaryButton(
            label: 'Proceed',
            onPressed: () {
              setState(() {
                salesList.insert(
                  index,
                  SalesOrderModel(
                      productName: searchController.text,
                      productQty: qtyController.text,
                      price: priceController.text),
                );
                // salesList.add(
                //   SalesOrderModel(
                //       productName: searchController.text,
                //       productQty: qtyController.text,
                //       price: priceController.text),
                // );
              });
              // if (index == null) {
              //   Navigator.pop(context);
              // } else {
              //   Navigator.pop(context);
              Navigator.pop(context);
              // }
            },
          )
        ]);
  }

  void selectedItem(BuildContext context, item, index) {
    switch (item) {
      case 0:
        {
          salesList.removeAt(index);
          Navigator.pop(context);
          break;
        }

      case 1:
        print(salesList);
    }
  }
}

class SalesOrderModel {
  SalesOrderModel({this.productName, this.productQty, this.price});
  String? productName;
  String? productQty;
  String? price;
}
