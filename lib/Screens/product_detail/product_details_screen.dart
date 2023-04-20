import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/product_detail/product_detail_controller.dart';
import 'package:hamrokhata/commons/api/api_constant.dart';
import 'package:hamrokhata/commons/utils/scanqr.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/text_form_widget.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/product_detail.dart';
import 'package:hamrokhata/models/request/product_search_request_model.dart';

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
      body: SingleChildScrollView(
        child: BaseWidget(builder: (contex, config, theme) {
          return GetBuilder<ProductDetailsController>(builder: (controller) {
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appVerticalPaddingMedium()),
              child: Column(
                children: [
                  config.verticalSpaceMedium(),
                  TextFieldWidget(
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
                  // config.verticalSpaceMedium(),
                  GetBuilder<ProductDetailsController>(builder: (controller) {
                    final result = controller.productSearchResponse;
                    if (result.hasData) {
                      ProductSearchResponse productSearchResponse = result.data;

                      return Column(
                        children: [
                          if (productSearchResponse.currentStock! < 10)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "This item is going to be out of Stock soon. \nDo you want to added to the required list? ",
                                  maxLines: 4,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                PrimaryButton(
                                    height: 30,
                                    width: 50,
                                    color: Colors.green,
                                    label: "Yes",
                                    onPressed: () {
                                      // controller.addRequiredList(context, productSearchResponse.id);
                                    }),
                              ],
                            ),
                          Card(
                            elevation: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      config.appVerticalPaddingMedium()),
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
                          ),
                          productSearchResponse.image != null
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Product Image: ",
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: Image.network(
                                        APIPathHelper.imageUrl +
                                            productSearchResponse.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
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
      ),
    );
  }
}
