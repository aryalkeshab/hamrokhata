import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/product_detail/product_detail_controller.dart';
import 'package:hamrokhata/commons/utils/scanqr.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/product_detail.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? scannedCode;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Product Details'),
      ),
      body: BaseWidget(builder: (contex, config, theme) {
        return GetBuilder<ProductDetailsController>(builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: config.appVerticalPaddingMedium()),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          PrimaryFormField(
                            onSaved: (saved) {},
                            onChanged: (value) {
                              // Get.find<ProductDetailsController>()
                              //     .getProductSearch(context, value);
                            },
                            hintIcon: IconButton(
                              icon: const Icon(CupertinoIcons.barcode),
                              onPressed: (() async {
                                searchController.text =
                                    await Scanqr.barcodeScanner(context);
                                print(searchController);
                              }),
                            ),
                            hintTxt: "Item No. ",
                            controller: searchController,
                          ),
                        ],
                      ),
                    ),
                    config.horizontalSpaceMedium(),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: PrimaryButton(
                              label: "Search",
                              onPressed: () {
                                Get.find<ProductDetailsController>()
                                    .getProductSearch(
                                        context, searchController.text);
                                // showSuccessToast(
                                //     'Successfully register the user. ');
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                config.verticalSpaceMedium(),
                GetBuilder<ProductDetailsController>(builder: (controller) {
                  final result = controller.productSearchResponse;
                  if (result.hasData) {
                    ProductSearchResponse productSearchResponse = result.data;

                    return Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: config.appVerticalPaddingMedium()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            config.verticalSpaceLarge(),
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
                            config.verticalSpaceMedium(),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    productSearchResponse.id.toString(),
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
                                    productSearchResponse.name.toString(),
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            config.verticalSpaceLarge(),
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
                                    "Discount Price",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            config.verticalSpaceMedium(),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    productSearchResponse.purchasePrice
                                        .toString(),
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
                                    productSearchResponse.sellingPrice
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            config.verticalSpaceLarge(),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Product Description",
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
                                    "Stock Count",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            config.verticalSpaceMedium(),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    productSearchResponse.description
                                        .toString(),
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
                                    productSearchResponse.currentStock
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            config.verticalSpaceLarge(),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: config.appVerticalPaddingMedium()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            config.verticalSpaceLarge(),
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
                            config.verticalSpaceMedium(),
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
                            config.verticalSpaceLarge(),
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
                                    "Discount Price",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            config.verticalSpaceMedium(),
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
                            config.verticalSpaceLarge(),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Product Description",
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
                                    "Stock Count",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            config.verticalSpaceMedium(),
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
                                    '--',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            config.verticalSpaceLarge(),
                          ],
                        ),
                      ),
                    );
                  }
                })
              ],
            ),
          );
        });
      }),
    );
  }
}
