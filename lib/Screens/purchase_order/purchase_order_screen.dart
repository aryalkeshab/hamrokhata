import 'package:draggable_fab/draggable_fab.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hamrokhata/Screens/product_detail/product_detail_controller.dart';
import 'package:hamrokhata/Screens/product_detail/product_details_screen.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_controller.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';
import 'package:hamrokhata/commons/utils/scanqr.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/dialog/bottom_sheet.dart';
import 'package:hamrokhata/commons/widgets/dialog/dialog_sales_order.dart';
import 'package:hamrokhata/commons/widgets/dialog/dialog_with_custom_child_and_buttons.dart';
import 'package:hamrokhata/commons/widgets/text_form_widget.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/customer_model.dart';
import 'package:hamrokhata/models/product_detail.dart';
import 'package:hamrokhata/models/request/purchase_request_model.dart';
import 'package:hamrokhata/models/sales_order_model.dart';
import 'package:hamrokhata/models/vendor_list.dart';

class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({super.key});

  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  int count = 100000;
  String? scannedCode;
  String? qty;
  String? price;
  String? productName;
  String? selectedVendor;
  int? selectedVendorId;

  String? selectedOrderStatus;
  double netTotal = 0.00;

  bool isSelectedFromUpdate = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  // List<TempPurchaseOrderModel> PurchaseList = [];
  List<PurchaseItems> purchaseList = [];
  ProductSearchResponse? productDetails;

  List<PurchaseOrderModel> purchaseOrderList = [];
  final formKey = GlobalKey<FormState>();
  List<String> orderStatus = ["Pending", "Failed", "Completed"];
  final secureStorage = Get.find<FlutterSecureStorage>();

  incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  void initState() {
    Get.find<PurchaseOrderController>().getVendorsList();
    super.initState();
  }

  List<VendorList> vendorAllList = [];

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductDetailsController());
    final purchaseOrderController = Get.put(PurchaseOrderController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Purchase Order Screen'),
        ),
        body: BaseWidget(builder: (context, config, theme) {
          return GetBuilder<PurchaseOrderController>(builder: (controller) {
            List<String> vendorList =
                Get.find<PurchaseOrderController>().vendorList;
            final result = controller.vendorslistResponse;
            if (result.hasData) {
              vendorAllList = result.data!;
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
                      child: DropdownSearch<String>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Select Vendor",
                            filled: true,
                          ),
                        ),
                        enabled: true,
                        popupProps: PopupProps.dialog(showSearchBox: true),
                        items: vendorList,
                        onChanged: (value) {
                          selectedVendor = value;
                        },
                      ),
                    ),
                    config.horizontalSpaceSmall(),
                    Expanded(
                      flex: 1,
                      child: DropdownSearch<String>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Order Status",
                            filled: true,
                          ),
                        ),
                        enabled: true,
                        // popupProps: PopupProps.dialog(showSearchBox: true),
                        items: orderStatus,
                        onChanged: (value) {
                          selectedOrderStatus = value;
                        },
                      ),
                    ),
                  ],
                ),
                config.verticalSpaceMedium(),
                config.verticalSpaceSmall(),
                const Divider(
                  height: 2,
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
                  children: List.generate(purchaseList.length, (index) {
                    PurchaseItems purchaseModelList = purchaseList[index];

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
                                  purchaseModelList.name ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  purchaseModelList.quantity ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  purchaseModelList.price.toString(),
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
                                        // '${purchaseModelList.total?.toStringAsFixed(2).toString()}',
                                        // '${purchaseModelList.total?.toStringAsFixed(2).toString()}',
                                        "${purchaseModelList.total}",
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
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Divider(
                height: 2,
              ),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
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
              Center(
                child: PrimaryButton(
                  label: 'Place purchase Order',
                  onPressed: () async {
                    vendorAllList.forEach((element) {
                      if (element.name == selectedVendor) {
                        selectedVendorId = element.id;
                      }
                    });
                    final userid = await secureStorage.read(
                        key: StorageConstants.loginStaff);

                    final purchaseOrderModel = PurchaseOrderModel(
                        userId: int.parse(userid.toString()),
                        purchaseItems: purchaseList,
                        status: selectedOrderStatus,
                        vendor: selectedVendorId);

                    if (selectedVendorId == null &&
                        selectedOrderStatus == null) {
                      showErrorToast(
                          "Vendor Name and Order Status is Mendetory!");
                    } else if (purchaseList.isNotEmpty) {
                      purchaseOrderController.purchaseOrder(
                          purchaseOrderModel, context);
                      // Get.toNamed(
                      //   Routes.purchaseOrderConformationScreen,
                      //   arguments: purchaseList,
                      // );
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

  customBottomSheet(
    context,
    int index,
  ) {
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
                    keyboardType: TextInputType.number,
                    onPressed: () {
                      controller.getProductSearch(
                          context, searchController.text);
                    },
                    onSaved: (value) {
                      controller.getProductSearch(context, value);
                    },
                    onChanged: (value) {
                      controller.getProductSearch(
                          context, searchController.text);
                    },
                    controller: searchController,
                    hintTxt: "Search Item No. ",
                    hintIcon: InkWell(
                      onTap: () async {
                        scannedCode = await Scanqr.barcodeScanner(context);
                        print(scannedCode);
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
                                    keyboardType: TextInputType.number,
                                    hintTxt: "eg 10 ",
                                    controller: qtyController,
                                    // validator: (value) =>
                                    //     Validator.validateNumber(value!),
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
                              // if (formKey.currentState!.validate()) {

                              if (productDetails.currentStock! >
                                  int.parse(qtyController.text)) {
                                if (isSelectedFromUpdate == false) {
                                  double total = 0.00;
                                  total = double.parse(qtyController.text) *
                                      double.parse(priceController.text);

                                  netTotal += total;

                                  setState(() {
                                    purchaseList.add(
                                      PurchaseItems(
                                          product: productDetails.id.toString(),
                                          quantity: qtyController.text,
                                          price: priceController.text,
                                          name: productDetails.name,
                                          total: total.toString()),
                                    );
                                  });
                                  Navigator.pop(context);
                                } else {
                                  netTotal = netTotal -
                                      double.parse(
                                          purchaseList[index].total.toString());
                                  double total2 = 0.00;
                                  total2 = double.parse(qtyController.text) *
                                      double.parse(priceController.text);
                                  setState(() {
                                    purchaseList.removeAt(index);
                                    netTotal += total2;

                                    purchaseList.insert(
                                      index,
                                      PurchaseItems(
                                          product: productDetails.id.toString(),
                                          quantity: qtyController.text,
                                          price: priceController.text,
                                          name: productDetails.name,
                                          total: total2.toString()),
                                    );
                                  });
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              } else {
                                showSuccessToast("Not enough stock");
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
                                  validator: (value) =>
                                      Validator.validateNumber(value!),
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
                            double.parse(purchaseList[index].total.toString());
                        purchaseList.removeAt(index);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });

                      showSuccessToast(
                          'New purchase Order $count is created !');
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
}

// class TemppurchaseOrderModel {
//   TemppurchaseOrderModel(
//       {this.productName, this.productQty, this.price, this.total});
//   String? productName;
//   String? productQty;
//   String? price;
//   double? total;
// }
