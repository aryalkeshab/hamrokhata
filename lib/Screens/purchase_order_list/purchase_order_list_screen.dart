import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list_controller.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/models/response/purchase_order_response_model.dart';

class PurchaseOrderListScreen extends StatefulWidget {
  const PurchaseOrderListScreen({super.key});

  @override
  State<PurchaseOrderListScreen> createState() =>
      _PurchaseOrderListScreenState();
}

class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen> {
  @override
  void initState() {
    Get.put(PurchaseOrderListController()).getpurchaseOrderList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Purchase Order List'),
      ),
      body: BaseWidget(builder: (context, config, theme) {
        return GetBuilder<PurchaseOrderListController>(builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: config.appHorizontalPaddingMedium()),
            child: Column(
              children: [
                // Text(
                //   'Total Amount: ${controller.purchaseOrderResponseList!.length ?? 0}',
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Date Filter: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.date_range, size: 25),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        } else {}
                      },
                    ),
                  ],
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
                          "Invoice No. ",
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
                          "Vendor Name",
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
                Builder(builder: (context) {
                  if (controller.purchaseOrderResponse.hasData) {
                    if (controller.purchaseOrderResponseList!.isEmpty) {
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
                        children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  controller.purchaseOrderResponseList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(controller
                                    .purchaseOrderResponseList![0].billNumber);
                                // TrackingModel trackingModel = trackingList[index];
                                return Visibility(
                                  child: Card(
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.table,
                                                  arguments: [
                                                    controller
                                                            .purchaseOrderResponseList![
                                                        index]
                                                  ]);
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    controller
                                                        .purchaseOrderResponseList![
                                                            index]
                                                        .billNumber
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    controller
                                                        .purchaseOrderResponseList![
                                                            index]
                                                        .vendor
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    controller
                                                        .purchaseOrderResponseList![
                                                            index]
                                                        .grandTotal
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
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
                        ],
                      );
                    }
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                }),
              ],
            ),
          );
        });
      }),
      bottomSheet:
          GetBuilder<PurchaseOrderListController>(builder: (controller) {
        num total = 0.0;
        for (int i = 0; i < controller.purchaseOrderResponseList!.length; i++) {
          total += Get.find<PurchaseOrderListController>()
              .purchaseOrderResponseList![i]
              .grandTotal!;
          // print(Get.find<PurchaseOrderListController>()
          //     .purchaseOrderResponseList![i]
          //     .billNumber);
        }
        print(total);
        // controller.purchaseOrderResponseList![]

        return Container(
          // color: Colors.black45,

          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Divider(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${total.toString()}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
