import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';
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
  String? dropDownvalue;
  double netTotal = 0.00;

  bool isSelectedFromUpdate = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  List<SalesOrderModel> salesList = [];

  incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  void initState() {
    Get.put(SalesOrderController()).getcustomerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Sales Order Screen'),
        ),
        body: BaseWidget(builder: (context, config, theme) {
          return GetBuilder<SalesOrderController>(builder: (controller) {
            List<String> customerList =
                Get.find<SalesOrderController>().customerList;
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appVerticalPaddingMedium()),
              child: Column(children: [
                config.verticalSpaceSmall(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: PrimaryButton(
                            label: 'New Order',
                            onPressed: () {
                              dialogWithCustomChildAndTwoButton(
                                  context: context,
                                  title:
                                      'Do you want to create new sales Order?',
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
                    ),
                    config.horizontalSpaceSmall(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text('---Select Customer ---'),
                            value: dropDownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: customerList.map((String vendorList) {
                              return DropdownMenuItem(
                                value: vendorList,
                                child: Text(vendorList),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropDownvalue = value;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                config.verticalSpaceSmall(),
                const Divider(
                  height: 2,
                ),
                config.verticalSpaceSmall(),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
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
                        flex: 2,
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
                        flex: 2,
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
                        flex: 2,
                        child: Text(
                          "Price",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Total",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Text(''),
                      // ),
                    ],
                  ),
                ),
                const Divider(
                  height: 2,
                ),
                Column(
                  children: List.generate(salesList.length, (index) {
                    SalesOrderModel salesModelList = salesList[index];

                    return Visibility(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  salesModelList.productName ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  salesModelList.productQty ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  salesModelList.price.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        '${salesModelList.total?.toStringAsFixed(2).toString()}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: popupMenuItem(
                                          context, config, theme, index),
                                    ),
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
          });
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
                setState(() {
                  isSelectedFromUpdate = false;
                  customDialog(
                      config: config,
                      context: context,
                      theme: theme,
                      index: null);
                });
              },
            );
          }),
        ),
        bottomSheet:

            // int price = salesList.add(int.parse(salesList[index].price))

            Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Divider(
                height: 2,
              ),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                // for (int i = 0; i <= salesList.length; i++) {
                //   print(salesList[i].price!);
                //   netTotal += double.parse(salesList[i].price!);
                // }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      netTotal.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ],
                );
              }),
            ],
          ),
        ));
  }

  customDialog({required context, required config, required theme, index}) {
    if (isSelectedFromUpdate == true) {
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
    final formKey = GlobalKey<FormState>();

    return dialogSalesOrderCustom(
        context: (context),
        title: 'Sales Order',
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          PrimaryFormField(
                            controller: searchController,
                            validator: (value) =>
                                Validator.validateNumber(value!),
                            onSaved: (saved) {
                              setState(() {
                                scannedCode = saved;
                              });
                            },
                            hintIcon: InkWell(
                              onTap: () async {
                                scannedCode =
                                    await Scanqr.barcodeScanner(context);
                                print(scannedCode);
                              },
                              child: const Icon(CupertinoIcons.barcode),
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
                            padding:
                                const EdgeInsets.only(right: 10.0, top: 10),
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
                        validator: (value) => Validator.validateNumber(value!),
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
                          validator: (value) =>
                              Validator.validateNumber(value!),
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
                    if (formKey.currentState!.validate()) {
                      if (isSelectedFromUpdate == false) {
                        double total = 0.00;
                        total = double.parse(qtyController.text) *
                            double.parse(priceController.text);
                        // for (int i = 0; i <= salesList.length; i++) {
                        //   print(salesList[i].price!);
                        //   netTotal += double.parse(salesList[i].price!);
                        // }
                        // print(netTotal);
                        netTotal += total;

                        setState(() {
                          salesList.add(
                            SalesOrderModel(
                                productName: searchController.text,
                                productQty: qtyController.text,
                                price: priceController.text,
                                total: total),
                          );
                        });
                        Navigator.pop(context);
                      } else {
                        netTotal = netTotal -
                            double.parse(salesList[index].total.toString());
                        double total2 = 0.00;
                        total2 = double.parse(qtyController.text) *
                            double.parse(priceController.text);
                        setState(() {
                          salesList.removeAt(index);
                          netTotal += total2;

                          salesList.insert(
                            index,
                            SalesOrderModel(
                                productName: searchController.text,
                                productQty: qtyController.text,
                                price: priceController.text,
                                total: total2),
                          );
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ]);
  }

  Widget popupMenuItem(context, config, theme, index) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert),
      // onSelected: (item) =>
      // selectedItem(context, item, index),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              setState(() {
                dialogWithCustomChildAndTwoButton(
                    context: context,
                    title: 'Do you want to Delete the Order?',
                    acceptFun: () {
                      setState(() {
                        netTotal = netTotal -
                            double.parse(salesList[index].total.toString());
                        salesList.removeAt(index);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });

                      showSuccessToast('New Sales Order $count is created !');
                      // Navigator.pop(context);
                    },
                    rejectFun: () {
                      Navigator.pop(context);
                    });
              });
            },
            child: const Icon(Icons.delete),
          ),
        ),
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              setState(() {
                isSelectedFromUpdate = true;
                customDialog(
                    config: config,
                    context: context,
                    theme: theme,
                    index: index);
              });
            },
            child: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}

class SalesOrderModel {
  SalesOrderModel({this.productName, this.productQty, this.price, this.total});
  String? productName;
  String? productQty;
  String? price;
  double? total;
}
