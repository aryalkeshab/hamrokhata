import 'package:draggable_fab/draggable_fab.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hamrokhata/Screens/product_detail/product_detail_controller.dart';
import 'package:hamrokhata/Screens/product_detail/product_details_screen.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';
import 'package:hamrokhata/commons/utils/scanqr.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/dialog/bottom_sheet.dart';
import 'package:hamrokhata/commons/widgets/dialog/dialog_sales_order.dart';
import 'package:hamrokhata/commons/widgets/dialog/dialog_with_custom_child.dart';
import 'package:hamrokhata/commons/widgets/dialog/dialog_with_custom_child_and_buttons.dart';
import 'package:hamrokhata/commons/widgets/text_form_widget.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/customer_model.dart';
import 'package:hamrokhata/models/product_detail.dart';
import 'package:hamrokhata/models/request/product_search_request_model.dart';
import 'package:hamrokhata/models/sales_order_model.dart';

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
  String? selectedCustomer;
  int? selectedCustomerId;
  String? selectedStatus;

  double netTotal = 0.00;
  List<String> orderStatus = ["Pending", "Failed", "Completed"];
  final secureStorage = Get.find<FlutterSecureStorage>();

  bool isSelectedFromUpdate = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController taxController = TextEditingController(text: "13.0");
  TextEditingController discountController = TextEditingController();

  // List<TempSalesOrderModel> salesList = [];
  List<SalesItems> salesList = [];
  ProductSearchResponse? productDetails;
  double tax = 0.0;
  double discount = 0.0;

  List<SalesOrderModel> salesOrderList = [];
  final formKey = GlobalKey<FormState>();
  List<CustomerModel> customerAllList = [];

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
    final productController = Get.put(ProductDetailsController());
    final salesOrderController = Get.put(SalesOrderController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Sales Order Screen'),
        ),
        body: BaseWidget(builder: (context, config, theme) {
          return GetBuilder<SalesOrderController>(builder: (controller) {
            List<String> customerList =
                Get.find<SalesOrderController>().customerList;
            // List<CustomerModel> customerModelList =
            //     Get.find<SalesOrderController>().customerApiResult;
            final result = controller.customerlistResponse;
            if (result.hasData) {
              customerAllList = result.data!;
            }

            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appVerticalPaddingMedium()),
              child: Column(children: [
                config.verticalSpaceSmall(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Customer Name",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Order Status",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: DropdownSearch<String>(
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Customer Select",
                            filled: true,
                          ),
                        ),
                        enabled: true,
                        popupProps:
                            const PopupProps.dialog(showSearchBox: true),
                        items: customerList,
                        onChanged: (value) {
                          selectedCustomer = value;
                        },
                      ),
                    ),
                    config.horizontalSpaceSmall(),
                    Expanded(
                      flex: 1,
                      child: DropdownSearch<String>(
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Order Status",
                            filled: true,
                          ),
                        ),
                        enabled: true,
                        // popupProps: PopupProps.dialog(showSearchBox: true),
                        items: orderStatus,
                        onChanged: (value) {
                          selectedStatus = value;
                        },
                      ),
                    ),
                  ],
                ),
                config.verticalSpaceSmall(),
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
                          "S.N ",
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
                    SalesItems salesModelList = salesList[index];

                    return Visibility(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${index + 1}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  salesModelList.name ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  salesModelList.quantity ?? '',
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
                                        // '${salesModelList.total?.toStringAsFixed(1).toString()}',
                                        // '${salesModelList.total?.toStringAsFixed(1).toString()}',
                                        "${salesModelList.total}",
//
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: popupMenuItem(context, config,
                                          theme, index, productController),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
                  customBottomSheet(context, 0);
                });
              },
            );
          }),
        ),
        bottomSheet: Container(
          height: 180,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Divider(
                height: 2,
              ),
              InkWell(
                onTap: () {
                  testdialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Disc. & Tax",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.add_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Sub Total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    netTotal.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Builder(builder: (context) {
                if (netTotal != 0 && discountController.text.isNotEmpty) {
                  discount = netTotal *
                      double.parse(discountController.text.toString()) /
                      100;
                  // discount = netTotal *
                  //     double.parse(discountController.text.toString()) /
                  //     100;
                }

                return Row(
                  children: [
                    Text("Discount"),
                    Spacer(),
                    Text(
                      discount.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              }),
              Builder(builder: (context) {
                if (netTotal != 0 && taxController.text.isNotEmpty) {
                  tax = netTotal *
                      double.parse(taxController.text.toString()) /
                      100;
                }
                return Row(
                  children: [
                    Text("Tax(13%)"),
                    Spacer(),
                    Text(
                      tax.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              }),
              Builder(builder: (context) {
                double total = 0.0;
                if (netTotal != 0 && taxController.text.isNotEmpty) {
                  total = netTotal - discount + tax;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Grand Total',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      total.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ],
                );
              }),
              Center(
                child: PrimaryButton(
                  height: 40,
                  width: 50,
                  label: 'Place Sales Order',
                  onPressed: () async {
                    customerAllList.forEach((element) {
                      if (element.name == selectedCustomer) {
                        selectedCustomerId = element.id;
                      }
                    });
                    final userid = await secureStorage.read(
                        key: StorageConstants.loginStaff);
                    taxController = TextEditingController(text: "13");

                    final purchaseOrderModel = SalesOrderModel(
                        userId: int.parse(userid.toString()),
                        salesItems: salesList,
                        status: selectedStatus,
                        discPercent:
                            int.parse(discountController.text.toString()),
                        taxPercent: int.parse(taxController.text.toString()),
                        customer: Customer(name: selectedCustomerId));

                    if (selectedCustomerId == null && selectedStatus == null) {
                      showErrorToast(
                          "Customer Name and Order Status is Mendetory!");
                    } else if (salesList.isNotEmpty) {
                      try {
                        await salesOrderController.salesOrder(
                            purchaseOrderModel, context);
                        salesList.clear();
                        selectedStatus = null;
                        selectedStatus = null;
                        qtyController.clear();
                        priceController.clear();
                        searchController.clear();
                        discountController.clear();
                        discount = 0.0;
                        taxController.clear();
                        tax = 0.0;
                        netTotal = 0.0;
                      } catch (e) {
                        showErrorToast("Something went wrong");
                      }
                      // salesOrderController.salesOrder(
                      //     purchaseOrderModel, context);
                    } else {
                      showErrorToast(
                          "Please add items and customer name to the order first.");
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  void resetvalues() {
    qtyController.text = '';
    priceController.text = '';
    searchController.text = '';
  }

  customBottomSheet(context, int index) {
    resetvalues();
    bottomSheet(context: context, children: [
      BaseWidget(builder: (context, config, theme) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: config.appVerticalPaddingMedium()),
          child: GetBuilder<ProductDetailsController>(
            builder: (controller) {
              // controller.getProductSearch(context, );
              return Column(
                children: [
                  config.verticalSpaceMedium(),
                  TextFieldWidget(
                    keyboardType: TextInputType.text,
                    onPressed: () {
                      controller.getProductSearch(
                          context,
                          ProductSearchRequestModel(
                            name: searchController.text,
                          ));
                    },
                    onSaved: (value) {
                      controller.getProductSearch(
                          context,
                          ProductSearchRequestModel(
                            name: searchController.text,
                          ));
                    },
                    onChanged: (value) {
                      // controller.getProductSearch(
                      //     context,
                      //     ProductSearchRequestModel(
                      //       name: searchController.text,
                      //     ));
                    },
                    controller: searchController,
                    hintTxt: "Search Item No. ",
                    hintIcon: InkWell(
                      onTap: () async {
                        scannedCode = await Scanqr.barcodeScanner(context);
                        print(scannedCode);
                        controller.getProductSearch(
                            context,
                            ProductSearchRequestModel(
                              sku: scannedCode,
                            ));
                      },
                      child: const Icon(CupertinoIcons.barcode),
                    ),
                  ),
                  config.verticalSpaceMedium(),
                  Builder(builder: (context) {
                    if (controller.productSearchResponse.hasData) {
                      final result = controller.productSearchResponse;
                      final ProductSearchResponse? productDetails = result.data;

                      priceController.text =
                          productDetails!.sellingPrice.toString();
                      // qtyController.text = productDetails.currentStock.toString();

                      return Column(
                        children: [
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
                            children: [
                              Expanded(
                                child: Text(
                                  productDetails.id.toString(),
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  productDetails.name.toString(),
                                  style: const TextStyle(
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
                                  keyboardType: TextInputType.number,
                                  hintTxt: "eg 10 ",
                                  // validator: (value) =>
                                  //     Validator.validateNumber(value!),
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
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter quantity";
                                      } else if (int.parse(value) == 0) {
                                        return "You cannot add 0 quantity !";
                                      } else if (productDetails.currentStock! <
                                          int.parse(value)) {
                                        return "You cannot add more than ${productDetails.currentStock} quantity !";
                                      } else {
                                        return null;
                                      }
                                    },
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
                              // for (int i = 0; i < salesList.length; i++) {
                              //   if (salesList[i].product ==
                              //       productDetails.id.toString()) {
                              //     showErrorToast(
                              //         "This item is already added to the list");
                              //     return;
                              //   } else
                              // }
                              if (searchController.text.isEmpty) {
                                showErrorToast(
                                    "Please enter item no. or scan barcode");
                              } else if (int.parse(qtyController.text) == 0) {
                                showErrorToast("You cannot add 0 quantity !");
                              } else if (productDetails.currentStock! >
                                  int.parse(qtyController.text)) {
                                if (isSelectedFromUpdate == false) {
                                  double total = 0.00;
                                  total = double.parse(qtyController.text) *
                                      double.parse(priceController.text);

                                  netTotal += total;

                                  setState(() {
                                    salesList.add(
                                      SalesItems(
                                          product: productDetails.id.toString(),
                                          quantity: qtyController.text,
                                          name: productDetails.name.toString(),
                                          price: priceController.text,
                                          total: total.toString()),
                                    );
                                  });
                                  Navigator.pop(context);
                                } else {
                                  netTotal = netTotal -
                                      double.parse(
                                          salesList[index].total.toString());
                                  double total2 = 0.00;
                                  total2 = double.parse(qtyController.text) *
                                      double.parse(priceController.text);
                                  setState(() {
                                    salesList.removeAt(index);
                                    netTotal += total2;

                                    salesList.insert(
                                      index,
                                      SalesItems(
                                          product: productDetails.id.toString(),
                                          quantity: qtyController.text,
                                          name: productDetails.name.toString(),
                                          price: priceController.text,
                                          total: total2.toString()),
                                    );
                                  });
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              } else {
                                showErrorToast("Not enough stock");
                              }
                              // }
                            },
                          )
                        ],
                      );
                    } else {
                      return Column(
                        children: [
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
                                  "--",
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
                                  "--",
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

                          // PrimaryButton(
                          //   label: 'Proceed',
                          //   onPressed: () {},
                          // )
                        ],
                      );
                    }
                  }),
                ],
              );
            },
          ),
        );
      })
    ]);
  }

  // customDialog(
  //     {required context,
  //     required config,
  //     required theme,
  //     index,
  //     ProductDetailsController? productDetailsController}) {
  //   if (isSelectedFromUpdate == true) {
  //     setState(() {
  //       searchController.text = salesList[index].product!;
  //       qtyController.text = salesList[index].quantity!;
  //       priceController.text = salesList[index].price!;
  //     });
  //   } else {
  //     searchController.clear();
  //     qtyController.clear();
  //     priceController.clear();
  //   }
  //   final formKey = GlobalKey<FormState>();

  //   return dialogSalesOrderCustom(
  //       context: (context),
  //       title: 'Sales Order',
  //       children: [
  //         Form(
  //           key: formKey,
  //           child: Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     flex: 3,
  //                     child: Stack(
  //                       children: [
  //                         PrimaryFormField(
  //                           controller: searchController,
  //                           validator: (value) =>
  //                               Validator.validateNumber(value!),
  //                           onSaved: (saved) {
  //                             setState(() {
  //                               scannedCode = saved;
  //                             });
  //                           },
  //                           hintIcon: InkWell(
  //                             onTap: () async {
  //                               scannedCode =
  //                                   await Scanqr.barcodeScanner(context);
  //                               print(scannedCode);
  //                             },
  //                             child: const Icon(CupertinoIcons.barcode),
  //                           ),
  //                           onChanged: (value) {
  //                             setState(() {
  //                               scannedCode = value;
  //                             });
  //                           },
  //                           hintTxt: "Item No. ",
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   config.horizontalSpaceMedium(),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Row(
  //                       children: [
  //                         Container(
  //                           padding:
  //                               const EdgeInsets.only(right: 10.0, top: 10),
  //                           child: IconButton(
  //                             icon: const Icon(Icons.search),
  //                             onPressed: () {
  //                               productDetailsController!.getProductSearch(
  //                                   context, searchController.text);
  //                             },
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),

  //               config.verticalSpaceMedium(),
  //               GetBuilder<ProductDetailsController>(builder: (controller) {
  //                 priceController.text = productDetailsController!
  //                     .productDetails[0].sellingPrice
  //                     .toString();
  //                 return Row(
  //                   children: const [
  //                     Expanded(
  //                       child: Text(
  //                         "Item No. ",
  //                         style: TextStyle(
  //                           color: Colors.grey,
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 10,
  //                     ),
  //                     Expanded(
  //                       child: Text(
  //                         "Product Name",
  //                         style: TextStyle(
  //                           color: Colors.grey,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 );
  //               }),
  //               // config.verticalSpaceSmall(),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text(
  //                       productDetailsController!.productDetails[0].id
  //                           .toString(),
  //                       style: TextStyle(
  //                           color: Colors.black54,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 18),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Expanded(
  //                     child: Text(
  //                       productDetailsController.productDetails[0].name
  //                           .toString(),
  //                       style: TextStyle(
  //                           color: Colors.black54,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 18),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               config.verticalSpaceMedium(),
  //               Row(
  //                 children: const [
  //                   Expanded(
  //                     child: Text(
  //                       "Price",
  //                       style: TextStyle(
  //                         color: Colors.grey,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Expanded(
  //                     child: Text(
  //                       "Qty to buy",
  //                       style: TextStyle(
  //                         color: Colors.grey,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               // config.verticalSpaceSmall(),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: PrimaryFormField(
  //                       controller: priceController,
  //                       hintTxt: "eg 10 ",
  //                       validator: (value) => Validator.validateNumber(value!),
  //                       onChanged: (value) {
  //                         setState(() {
  //                           price = value;
  //                         });
  //                       },
  //                       onSaved: (value) {
  //                         setState(() {
  //                           price = value;
  //                         });
  //                       },
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 10,
  //                   ),
  //                   Expanded(
  //                     child: PrimaryFormField(
  //                         hintTxt: "eg 10 ",
  //                         controller: qtyController,
  //                         validator: (value) =>
  //                             Validator.validateNumber(value!),
  //                         onChanged: (value) {
  //                           setState(() {
  //                             qty = value;
  //                           });
  //                         },
  //                         onSaved: (value) {
  //                           setState(() {
  //                             qty = value;
  //                           });
  //                         }),
  //                   ),
  //                 ],
  //               ),
  //               config.verticalSpaceMedium(),
  //               PrimaryButton(
  //                 label: 'Proceed',
  //                 onPressed: () {
  //                   if (formKey.currentState!.validate()) {
  //                     if (isSelectedFromUpdate == false) {
  //                       double total = 0.00;
  //                       total = double.parse(qtyController.text) *
  //                           double.parse(priceController.text);
  //                       // for (int i = 0; i <= salesList.length; i++) {
  //                       //   print(salesList[i].price!);
  //                       //   netTotal += double.parse(salesList[i].price!);
  //                       // }
  //                       // print(netTotal);
  //                       netTotal += total;

  //                       setState(() {
  //                         salesList.add(
  //                           SalesItems(
  //                               product: searchController.text,
  //                               quantity: qtyController.text,
  //                               price: priceController.text,
  //                               total: total.toString()),
  //                         );
  //                       });
  //                       Navigator.pop(context);
  //                     } else {
  //                       netTotal = netTotal -
  //                           double.parse(salesList[index].total.toString());
  //                       double total2 = 0.00;
  //                       total2 = double.parse(qtyController.text) *
  //                           double.parse(priceController.text);
  //                       setState(() {
  //                         salesList.removeAt(index);
  //                         netTotal += total2;

  //                         salesList.insert(
  //                           index,
  //                           SalesItems(
  //                               product: searchController.text,
  //                               quantity: qtyController.text,
  //                               price: priceController.text,
  //                               total: total2.toString()),
  //                         );
  //                       });
  //                       Navigator.pop(context);
  //                       Navigator.pop(context);
  //                     }
  //                   }
  //                 },
  //               )
  //             ],
  //           ),
  //         ),
  //       ]);
  // }

  Widget popupMenuItem(context, config, theme, index, productController) {
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
                customBottomSheet(context, index);
                // customDialog(
                //     config: config,
                //     context: context,
                //     theme: theme,
                //     index: index,
                //     productDetailsController: productController);
              });
            },
            child: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }

  testdialog(BuildContext context) {
    return dialogWithCustomChildren(
        context: context,
        title: "Discount and Tax Calculation",
        rowchild: [
          Expanded(
            child: PrimaryFormField(
              label: "Discount Percent",
              controller: discountController,
              keyboardType: TextInputType.number,
              validator: (value) => Validator.validatePercentage(value!),

              hintTxt: "eg 10 ",
              // validator: (value) =>
              //     Validator.validateNumber(value!),
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
              label: "Tax Percent",
              controller: taxController,
              keyboardType: TextInputType.number,
              validator: (value) => Validator.validatePercentage(value!),
              enabled: false,

              hintTxt: "13 ",
              // validator: (value) =>
              //     Validator.validateNumber(value!),
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
        ],
        child: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              PrimaryButton(
                height: 40,
                width: 20,
                label: "Proceed",
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        ]);
  }
}

// class TempSalesOrderModel {
//   TempSalesOrderModel(
//       {this.productName, this.productQty, this.price, this.total});
//   String? productName;
//   String? productQty;
//   String? price;
//   double? total;
// }
