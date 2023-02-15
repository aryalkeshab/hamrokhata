import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/product_detail/product_detail_controller.dart';
import 'package:hamrokhata/commons/utils/scanqr.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/text_form_widget.dart';
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
                config.verticalSpaceMedium(),
                TextFieldWidget(
                  onPressed: () {
                    controller.getProductSearch(context, searchController.text);
                  },
                  onSaved: (value) {
                    controller.getProductSearch(context, value);
                  },
                  onChanged: (value) {
                    controller.getProductSearch(context, value);
                  },
                  controller: searchController,
                  hintTxt: "Search Item No. ",
                  hintIcon: InkWell(
                    onTap: () async {
                      scannedCode = await Scanqr.barcodeScanner(context);
                      print(scannedCode);
                      controller.getProductSearch(context, scannedCode);
                    },
                    child: const Icon(CupertinoIcons.barcode),
                  ),
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
                                    "Purchase Price",
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
                                    "Selling Price",
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
