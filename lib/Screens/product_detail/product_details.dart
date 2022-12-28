import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hamrokhata/commons/utils/scanqr.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

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
                    child: Container(
                      padding: const EdgeInsets.only(right: 10.0, top: 10),
                      child: PrimaryButton(
                          label: "Search",
                          onPressed: () {
                            showSuccessToast(
                                'Successfully register the user. ');
                          }),
                    ),
                  ),
                ],
              ),
              config.verticalSpaceMedium(),
              Card(
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
                              '9006',
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
                              'Hand Fan',
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
                              '1000',
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
                              '900',
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
                              'Fan with 3000 rpm capacity.',
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
                              '5',
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
              )
            ],
          ),
        );
      }),
    );
  }
}
