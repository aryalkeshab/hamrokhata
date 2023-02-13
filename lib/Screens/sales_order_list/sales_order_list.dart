import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list_controller.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/Screens/sales_order_list/sales_order_list_controller.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/models/response/purchase_order_response_model.dart';

class SalesOrderListScreen extends StatefulWidget {
  const SalesOrderListScreen({super.key});

  @override
  State<SalesOrderListScreen> createState() => _SalesOrderListScreenState();
}

class _SalesOrderListScreenState extends State<SalesOrderListScreen> {
  @override
  void initState() {
    Get.put(SalesOrderListController()).getsalesOrderList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('sales Order List'),
      ),
      body: BaseWidget(builder: (context, config, theme) {
        return GetBuilder<SalesOrderListController>(builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: config.appHorizontalPaddingMedium()),
            child: Column(
              children: [
                Text(
                  'Total Amount: ${controller.salesOrderResponseList!.length ?? 0}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                          "Customer Name",
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
                  if (controller.salesOrderResponse.hasData) {
                    if (controller.salesOrderResponseList!.isEmpty) {
                      return const Center(
                        child: Text('No Data Found'),
                      );
                    } else {
                      return Column(
                        children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  controller.salesOrderResponseList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                // print(
                                //     controller.salesOrderResponseList![0].billNumber);
                                // TrackingModel trackingModel = trackingList[index];
                                return Visibility(
                                  child: Card(
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
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
                                              flex: 1,
                                              child: Text(
                                                controller
                                                    .salesOrderResponseList![
                                                        index]
                                                    .customer
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
                                                    .salesOrderResponseList![
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
                        const Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }
                }),
              ],
            ),
          );
        });
      }),
      bottomSheet: GetBuilder<SalesOrderListController>(builder: (controller) {
        num total = 0.0;

        // if (controller.salesOrderResponseList![0].grandTotal != null) {
        //   for (int i = 0; i < controller.salesOrderResponseList!.length; i++) {
        //     total += controller.salesOrderResponseList![i].grandTotal!;
        //     // print(Get.find<PurchaseOrderListController>()
        //     //     .purchaseOrderResponseList![i]
        //     //     .billNumber);
        //   }
        // }

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
