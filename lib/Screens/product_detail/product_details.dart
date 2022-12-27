import 'package:flutter/material.dart';
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
                    child: Stack(
                      children: [
                        // Container(
                        //   // padding: EdgeInsets.s,
                        //   child: TextFormField(),
                        // ),
                        PrimaryFormField(
                          onSaved: (saved) {},
                          hintIcon: const Icon(
                              Icons.production_quantity_limits_rounded),
                          hintTxt: "Item No. ",
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   child: PrimaryButton(
                  //       label: "Sign up",
                  //       onPressed: () {
                  //         showSuccessToast(
                  //             'Successfully register the user. ');
                  //         // Get.toNamed(Routes.login);
                  //       }),
                  // )

                  // Container(
                  //   color: Colors.blue,
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 6),
                  //     child: IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(
                  //         Icons.arrow_forward_ios_rounded,
                  //         color: Colors.orange,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              config.horizontalSpaceMedium(),
              config.horizontalSpaceMedium(),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: config.appVerticalPaddingMedium()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 10),
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
                      SizedBox(height: 20),
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
                      const SizedBox(height: 10),
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
                      SizedBox(height: 20),
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
