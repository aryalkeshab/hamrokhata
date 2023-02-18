import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_controller.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list.dart';
import 'package:hamrokhata/Screens/purchase_order_list/purchase_order_list_controller.dart';
import 'package:hamrokhata/Screens/sales_order/sales_order_controller.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/models/response/purchase_order_response_model.dart';
import 'package:supercharged/supercharged.dart';

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
    final purchaseOrderListController = Get.put(PurchaseOrderController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Purchase Order List'),
      ),
      body: BaseWidget(builder: (context, config, theme) {
        return GetBuilder<PurchaseOrderListController>(builder: (controller) {
          return SingleChildScrollView(
            child: Container(
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                            "S.N.",
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
                            "Vendor Name",
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
                                itemCount: controller
                                    .purchaseOrderResponseList!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  print(controller.purchaseOrderResponseList![0]
                                      .billNumber);
                                  // TrackingModel trackingModel = trackingList[index];
                                  //to extract vendor number from venor list and show it in vendor number column
                                  //   String vendorNumber =
                                  //   Get.find<PurchaseOrderController>().vendorApiResult

                                  //  [controller.v
                                  //           .indexWhere((element) =>
                                  //               element.vendorName ==
                                  //               controller
                                  //                   .purchaseOrderResponseList![
                                  //                       index]
                                  //                   .vendorName)]
                                  //       .vendorNumber
                                  //       .toString();

                                  //  vendorid taken from purchase OrderResponseList and match with  vendor number in vendorapiresult.id

                                  // String vendorName =
                                  //     Get.find<PurchaseOrderController>()
                                  //         .vendorApiResult[controller
                                  //             .purchaseOrderResponseList![index]
                                  //             .vendor
                                  //             .toInt()]
                                  //         .name!;

                                  // print(vendorName);

                                  return Visibility(
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.table, arguments: [
                                          controller
                                              .purchaseOrderResponseList![index]
                                        ]);
                                      },
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
                                                        "${index + 1}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        controller
                                                            .purchaseOrderResponseList![
                                                                index]
                                                            .billNumber
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        controller
                                                            .purchaseOrderResponseList![
                                                                index]
                                                            .vendor
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        controller
                                                            .purchaseOrderResponseList![
                                                                index]
                                                            .grandTotal
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
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
                                    ),
                                  );
                                }),
                            config.verticalSpaceExtraLarge(),
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

          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Divider(
                height: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${total.toStringAsFixed(2)}',
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
//method to print a receipt using bluetooth printer in flutter
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:pos_app/core/config.dart';
// import 'package:pos_app/core/models/purchase_order_model.dart';
// import 'package:pos_app/core/viewmodels/purchase_order_controller.dart';
// import 'package:pos_app/ui/views/base_view.dart';
// import 'package:pos_app/ui/widgets/custom_button.dart';
// import 'package:pos_app/ui/widgets/custom_text.dart';
// import 'package:pos_app/ui/widgets/custom_text_field.dart';
// import 'package:pos_app/ui/widgets/progress_dialog.dart';
// import 'package:pos_app/ui/widgets/snackbar.dart';
// import 'package:pos_app/ui/widgets/toast.dart';
// import 'package:pos_app/utils/constants.dart';   
// import 'package:pos_app/utils/size_config.dart';
// import 'package:pos_app/utils/strings.dart';
// import 'package:pos_app/utils/styles.dart';
// import 'package:pos_app/utils/utils.dart';
// import 'package:pos_app/utils/validator.dart';
// import 'package:pos_app/utils/extensions.dart';


// class PurchaseOrderList extends StatefulWidget {
//   @override
//   _PurchaseOrderListState createState() => _PurchaseOrderListState();
// }
// class _PurchaseOrderListState extends State<PurchaseOrderList> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();
//   final _formKey1 = GlobalKey<FormState>();
//   final _formKey2 = GlobalKey<FormState>();
//   final _formKey3 = GlobalKey<FormState>();
//   final _formKey4 = GlobalKey<FormState>();
//   final _formKey5 = GlobalKey<FormState>();
//   final _formKey6 = GlobalKey<FormState>();
//   final _formKey7 = GlobalKey<FormState>();
//   final _formKey8 = GlobalKey<FormState>();
//   final _formKey9 = GlobalKey<FormState>();
//   final _formKey10 = GlobalKey<FormState>();
//   final _formKey11 = GlobalKey<FormState>();
//   final _formKey12 = GlobalKey<FormState>();
//   final _formKey13 = GlobalKey<FormState>();
//   final _formKey14 = GlobalKey<FormState>();
//
//
//   final TextEditingController _textEditingController =
//       new TextEditingController();
//   final TextEditingController _textEditingController1 =
//       new TextEditingController();
//   final TextEditingController _textEditingController2 =
//       new TextEditingController();
//
//   final TextEditingController _textEditingController3 =
//       new TextEditingController();
//   final TextEditingController _textEditingController4 =
//
//
//
//
//
//     new TextEditingController();
//  