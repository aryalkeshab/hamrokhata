import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:hamrokhata/Screens/bluetooth/app_setting.dart';
import 'package:hamrokhata/Screens/bluetooth/app_setting_controller.dart';
import 'package:hamrokhata/Screens/bluetooth/print_utils.dart';
import 'package:hamrokhata/Screens/purchase_order/purchase_order_controller.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/dialog/dialog_with_custom_child.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/request/product_request_model.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? dropDownvalue;
  File? imagePath;
  String? imageName;
  int? category;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    Get.put(PurchaseOrderController()).getCategoryList();

    super.initState();
  }

  final secureStorage = FlutterSecureStorage();

  final ProductRequestModel addProductParams = ProductRequestModel();

  @override
  Widget build(BuildContext context) {
    final appController = Get.put(AppSettingController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Add Product '),
      ),
      body: SingleChildScrollView(
        child: HookBaseWidget(builder: (context, config, theme) {
          final _purchaseOrderFormKey = useMemoized(GlobalKey<FormState>.new);

          return GetBuilder<PurchaseOrderController>(builder: (controller) {
            List<String> categoryList =
                Get.find<PurchaseOrderController>().categoryList;

            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appVerticalPaddingMedium()),
              child: Form(
                key: _purchaseOrderFormKey,
                child: Column(
                  children: [
                    config.verticalSpaceMedium(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.black26),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: const Text('--Select Category--'),
                                    value: dropDownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items:
                                        categoryList.map((String categoryList) {
                                      return DropdownMenuItem(
                                        value: categoryList,
                                        child: Text(categoryList),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropDownvalue = value;
                                        // addProductParams
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        config.horizontalSpaceMedium(),
                        Expanded(
                          flex: 1,
                          child: Container(
                              //show upload button after choosing image
                              child: ElevatedButton.icon(
                            onPressed: () async {
                              await testdialog(context);

                              print(imagePath);
                            },
                            icon: const Icon(Icons.file_upload),
                            label: const Text("UPLOAD IMAGE"),
                          )),
                        ),
                      ],
                    ),
                    config.verticalSpaceMedium(),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: PrimaryFormField(
                            onSaved: (saved) {
                              addProductParams.name = saved;
                            },
                            label: "Product Name*",
                            hintTxt: 'eg. fan',
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    config.verticalSpaceMedium(),

                    Row(
                      children: [
                        // Expanded(
                        //   child: PrimaryFormField(
                        //     onSaved: (String saved) {
                        //       addProductParams.currentStock =
                        //           int.parse(saved);
                        //     },
                        //     label: "Quantity Added*",
                        //     hintTxt: '5',
                        //     keyboardType: TextInputType.phone,
                        //   ),
                        // ),
                        Expanded(
                          child: PrimaryFormField(
                            onSaved: (String saved) {
                              addProductParams.sellingPrice =
                                  double.parse(saved);
                            },
                            label: "Selling Price*",
                            hintTxt: '150',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        config.horizontalSpaceMedium(),
                        Expanded(
                          child: PrimaryFormField(
                            onSaved: (String saved) {
                              addProductParams.purchasePrice =
                                  double.parse(saved);
                            },
                            label: "Purchase Price*",
                            hintTxt: '200',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    config.verticalSpaceMedium(),
                    //  config.verticalSpaceExtraLarge(),
                    config.verticalSpaceMedium(),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (saved) {
                              addProductParams.description = saved;
                            },
                            label: "Product Description*",
                            hintTxt: 'description..',
                          ),
                        ),
                        config.horizontalSpaceMedium(),
                        Expanded(
                          child: PrimaryFormField(
                            onSaved: (String saved) {
                              addProductParams.type = saved;
                            },
                            label: "Type*",
                            hintTxt: 'Clothes',
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    config.verticalSpaceMedium(),
                    imagePath != null
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                child: Image.file(
                                  imagePath!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    config.verticalSpaceMedium(),
                    PrimaryButton(
                        onPressed: () async {
                          controller.categoryModelList.forEach((element) {
                            if (element.name == dropDownvalue) {
                              category = element.id!;
                            }
                          });

                          final currentState =
                              _purchaseOrderFormKey.currentState;
                          if (currentState != null) {
                            currentState.save();

                            if (currentState.validate()) {
                              dio.FormData formData = dio.FormData.fromMap({
                                "name": addProductParams.name,
                                "description": addProductParams.description,
                                "purchase_price":
                                    addProductParams.purchasePrice,
                                "selling_price": addProductParams.sellingPrice,
                                "type": addProductParams.type,
                                'category': category,
                                'image': await dio.MultipartFile.fromFile(
                                    imagePath!.path),
                              });
                              try {
                                controller.addProduct(
                                    addProductParams, context, formData);
                                currentState.reset();
                                imagePath == null;
                                dropDownvalue == null;
                              } catch (e) {
                                print(e);
                              }
                            }
                          }
                        },
                        label: 'Proceed'),
                  ],
                ),
              ),
            );
          });
        }),
      ),
    );
  }

  testdialog(BuildContext context) {
    return dialogWithCustomChildren(
        context: context,
        title: "Choose a picture Medium:",
        child: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Icon(
                  Icons.camera,
                  size: 50,
                ),
                onTap: () async {
                  Get.back();
                  await openCamera();
                },
              ),
              InkWell(
                child: Icon(
                  Icons.photo,
                  size: 50,
                ),
                onTap: () async {
                  Get.back();
                  await chooseFile();
                },
              ),
            ],
          )
        ]);
  }

  openCamera() async {
    // try {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        imagePath = File(image.path);

        print(imagePath!.path);
      });
    }
    // } catch (e) {
    //   showErrorToast("No camera available for taking pictures");
    // }
  }

  chooseFile() async {
    try {
      XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (image != null) {
        setState(() {
          imagePath = File(image.path);
        });
      }
    } catch (e) {
      showErrorToast(e.toString());
    }
  }
}
