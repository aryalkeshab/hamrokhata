import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/Screens/sales_order_list/sales_order_list_controller.dart';
import 'package:hamrokhata/commons/resources/confirm_dialog_view.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/text_form_widget.dart';
import 'package:hamrokhata/models/request/sales_list_request_params.dart';
import 'package:hamrokhata/models/request/sales_order_model.dart';
// import 'package:hamrokhata/models/request/sales_order_model.dart';

class SalesOrderListScreen extends StatefulWidget {
  const SalesOrderListScreen({super.key});

  @override
  State<SalesOrderListScreen> createState() => _SalesOrderListScreenState();
}

class _SalesOrderListScreenState extends State<SalesOrderListScreen> {
  @override
  void initState() {
    final formattedDate = DateTime.now().toString();
    final time = formattedDate.split(' ')[0];

    Get.put(SalesOrderListController())
        .getsalesOrderList(SalesListRequestParams(created_at: time));
    _controller.clear();

    super.initState();
  }

  DateTimeRange? _selectedDateRange;
  String? formattedFirstDate = '';
  String? formattedEndDate = '';
  TextEditingController searchController = TextEditingController();
  List<String> orderStatus = ["Pending", "Failed", "Completed"];
  String? selectedStatus;
  double total = 0.0;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    total = 0.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Sales Order List'),
      ),
      body: BaseWidget(builder: (context, config, theme) {
        return GetBuilder<SalesOrderListController>(builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appHorizontalPaddingMedium()),
              child: Column(
                children: [
                  // Text(
                  //   'Total Amount: ${controller.salesOrderResponseList!.length ?? 0}',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  TextFieldWidget(
                    onPressed: () {
                      controller.getsalesOrderList(SalesListRequestParams(
                        customer: searchController.text,
                        start_date: formattedFirstDate,
                        end_date: formattedEndDate,
                        status: selectedStatus,
                      ));
                    },
                    controller: searchController,
                    onSaved: (value) {},
                    onChanged: (value) {
                      // controller.getProductSearch(context, value);
                    },
                    // controller: searchController,
                    hintTxt: "Search Customer Name ",
                    // hintIcon: InkWell(
                    //   onTap: () async {
                    //     DateTime? pickedDate = await showDatePicker(
                    //         context: context,
                    //         initialDate: DateTime.now(),
                    //         firstDate: DateTime(1950),
                    //         currentDate: DateTime.now(),
                    //         lastDate: DateTime.now());

                    //     if (pickedDate != null) {
                    //       //pickedDate output format => 2021-03-10 00:00:00.000

                    //       selectedDate = pickedDate;
                    //     } else {}
                    //   },
                    //   child: const Icon(Icons.date_range),
                    // ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              const Text(
                                'Date Filter: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.date_range, size: 25),
                                onPressed: () async {
                                  DateTimeRange? pickedDate =
                                      await showDateRangePicker(
                                          context: context,
                                          // initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          currentDate: DateTime.now(),
                                          saveText: 'Done',
                                          lastDate: DateTime.now());

                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    //pickedDate output format => 2021-03-10 00:00:00.000

                                    _selectedDateRange = pickedDate;
                                    final firstDate =
                                        _selectedDateRange!.start.toString();
                                    final endDate =
                                        _selectedDateRange!.end.toString();
                                    formattedFirstDate =
                                        firstDate!.split(' ')[0];
                                    formattedEndDate = endDate!.split(' ')[0];
                                    setState(() {});
                                  } else {}
                                },
                              ),
                            ],
                          )),
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
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text(
                  //       'Date Filter: ',
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold, fontSize: 16),
                  //     ),
                  //     IconButton(
                  //       icon: const Icon(Icons.date_range, size: 25),
                  //       onPressed: () async {},
                  //     ),
                  //   ],
                  // ),
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
                            "S.N",
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
                            "Invoice No. ",
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
                            "Customer Name",
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
                  Builder(builder: (context) {
                    if (controller.salesOrderResponse.hasData) {
                      if (controller.salesOrderResponseList!.isEmpty) {
                        return const Center(
                          child: Text('No Data Found'),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  controller.salesOrderResponseList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                // int customerId = int.parse(controller
                                //     .salesOrderResponseList![index]
                                //     .customer!
                                //     .name
                                //     .toString());
                                // print(customerId);

                                // List<CustomerModel> customerList =
                                //     Get.find<SalesOrderController>()
                                //         .customerApiResult;

                                // print(customerList);

                                // String CustomerName = customerList
                                //     .firstWhere(
                                //         (element) => element.id == customerId)
                                //     .name!;
                                // print(CustomerName);
                                String CustomerName = controller
                                    .salesOrderResponseList![index].customer!;

                                return Visibility(
                                  child: Card(
                                    color: controller
                                                .salesOrderResponseList![index]
                                                .status ==
                                            "Failed"
                                        ? Colors.red[100]
                                        : controller
                                                    .salesOrderResponseList![
                                                        index]
                                                    .status ==
                                                "Completed"
                                            ? Colors.green[100]
                                            : Colors.yellow[100],
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.tableForSalesReceipt,
                                              arguments: [
                                                controller
                                                        .salesOrderResponseList![
                                                    index]
                                              ]);
                                        },
                                        onLongPress: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ConfirmDialogView(
                                                primaryText:
                                                    "Are you sure want to Void the transaction?",
                                                onApproveButtonPressed: () {
                                                  int? id = controller
                                                      .salesOrderResponseList![
                                                          index]
                                                      .id;

                                                  final tempController = controller
                                                          .salesOrderResponseList![
                                                      index];
                                                  List<SalesItemsRequest>?
                                                      salesItems = [];
                                                  print(tempController
                                                      .salesItems!.length);
                                                  for (int i = 0;
                                                      i <
                                                          tempController
                                                              .salesItems!
                                                              .length;
                                                      i++) {
                                                    print('a');
                                                    salesItems
                                                        .add(SalesItemsRequest(
                                                      product: tempController
                                                          .salesItems![i]
                                                          .product
                                                          .toString(),
                                                      quantity: tempController
                                                          .salesItems![i]
                                                          .quantity
                                                          .toString(),
                                                    ));
                                                  }
                                                  final result = Get.put(
                                                          SalesOrderController())
                                                      .salesOrderUpdate(
                                                          SalesOrderRequestModel(
                                                            status: "Failed",
                                                            salesItems:
                                                                salesItems,
                                                            discPercent:
                                                                tempController
                                                                    .discPercent,
                                                            taxPercent: 13,
                                                            customer:
                                                                tempController
                                                                    .customer,
                                                            userId:
                                                                tempController
                                                                    .salesBy,
                                                          ),
                                                          id!,
                                                          context);

                                                  if (result.hasData) {
                                                    controller.getsalesOrderList(
                                                        SalesListRequestParams(
                                                      customer:
                                                          searchController.text,
                                                      start_date:
                                                          formattedFirstDate,
                                                      end_date:
                                                          formattedEndDate,
                                                      status: selectedStatus,
                                                    ));
                                                    Get.back();
                                                  } else {}
                                                },
                                                onCancelButtonPressed: Get.back,
                                              );
                                            },
                                          ).then((value) => setState(() {
                                                controller.getsalesOrderList(
                                                    SalesListRequestParams(
                                                  customer:
                                                      searchController.text,
                                                  start_date:
                                                      formattedFirstDate,
                                                  end_date: formattedEndDate,
                                                  status: selectedStatus,
                                                ));
                                              }));
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "${index + 1}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                controller
                                                    .salesOrderResponseList![
                                                        index]
                                                    .invoiceNumber
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                CustomerName,
                                                maxLines: 2,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                controller
                                                    .salesOrderResponseList![
                                                        index]
                                                    .grandTotal
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    } else if (controller.salesOrderResponse.hasError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text('No Data Found'),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(child: CircularProgressIndicator()),
                        ],
                      );
                    }
                  }),
                  config.verticalSpaceExtraLarge(),
                ],
              ),
            ),
          );
        });
      }),
      bottomSheet: GetBuilder<SalesOrderListController>(builder: (controller) {
        _controller.clear();
        // if (controller.salesOrderResponseList![0].grandTotal != null) {
        for (int i = 0; i < controller.salesOrderResponseList!.length; i++) {
          // total += controller.salesOrderResponseList![i].grandTotal!;

          total += controller.salesOrderResponseList![i].grandTotal!;
          // print(Get.find<PurchaseOrderListController>()
          //     .purchaseOrderResponseList![i]
          //     .billNumber);
        }
        _controller.text = total.toStringAsFixed(2);

        return Container(
          // color: Colors.black45,

          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Divider(
                height: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Builder(builder: (context) {
                    if (controller.salesOrderResponse.hasError) {
                      return Text(
                        '0.00',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.right,
                      );
                    } else {
                      return Text(
                        '${double.parse(_controller.text).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.right,
                      );
                    }
                  }),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
