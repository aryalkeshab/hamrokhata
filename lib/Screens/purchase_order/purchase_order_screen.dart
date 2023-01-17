import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_controller.dart';
import 'package:hamrokhata/commons/api/config.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/vendor_list.dart';

class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({super.key});

  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  String? dropDownvalue;
  @override
  void initState() {
    Get.put(PurchaseOrderController()).getVendorsList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Purchase Order'),
      ),
      body: SingleChildScrollView(
        child: BaseWidget(builder: (context, config, theme) {
          return GetBuilder<PurchaseOrderController>(builder: (controller) {
            List<String> vendorList =
                Get.find<PurchaseOrderController>().vendorList;

            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appVerticalPaddingMedium()),
              child: Column(
                children: [
                  config.verticalSpaceExtraLarge(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Vendor Selection :',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text('---Select Vendor ---'),
                            value: dropDownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: vendorList.map((String vendorList) {
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
                    ],
                  ),
                  config.verticalSpaceMedium(),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryFormField(
                          onSaved: (saved) {},
                          label: "Item No.*",
                          hintTxt: '1017',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      config.horizontalSpaceMedium(),
                      Expanded(
                        child: PrimaryFormField(
                          onSaved: (saved) {},
                          label: "Product Name*",
                          hintTxt: 'eg. fan',
                        ),
                      ),
                    ],
                  ),
                  config.verticalSpaceMedium(),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryFormField(
                          onSaved: (saved) {},
                          label: "Quantity Added*",
                          hintTxt: '5',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      config.horizontalSpaceMedium(),
                      Expanded(
                        child: PrimaryFormField(
                          onSaved: (saved) {},
                          label: "Purchase Price*",
                          hintTxt: '200',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  config.verticalSpaceMedium(),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryFormField(
                          onSaved: (saved) {},
                          label: "Selling Price*",
                          hintTxt: '150',
                        ),
                      ),
                      config.horizontalSpaceMedium(),
                      Expanded(
                        child: PrimaryFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (saved) {},
                          label: "Product Description*",
                          hintTxt: 'description..',
                        ),
                      ),
                    ],
                  ),
                  config.verticalSpaceMedium(),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: "  Enter your product description here",
                        contentPadding: EdgeInsets.all(20.0),
                        fillColor: Colors.black45,
                        border: OutlineInputBorder(
                          gapPadding: 15,
                        )),
                    maxLines: 6,
                  ),
                  config.verticalSpaceExtraLarge(),
                  PrimaryButton(
                      onPressed: () {
                        showSuccessToast('Saved your data to the database !');
                      },
                      label: 'Proceed')
                ],
              ),
            );
          });
        }),
      ),
    );
  }
}
