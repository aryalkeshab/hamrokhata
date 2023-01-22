import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/register/register_controller.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';

import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/request/register_params.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterParams registerParams = RegisterParams();
  final _formKey = GlobalKey<FormState>();
  List<String> positionList = ["administrator", "Staff"];
  String? dropDownvalue;

  @override
  Widget build(BuildContext context) {
    // final authController = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: BaseWidget(
          builder: (context, config, theme) {
            return GetBuilder<RegisterController>(builder: (controller) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: config.appHorizontalPaddingLarge(),
                ),
                child: HookBaseWidget(builder: (context, config, theme) {
                  final registerFormKey = useMemoized(GlobalKey<FormState>.new);

                  return Form(
                    key: registerFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset("assets/images/app_logo.png"),
                        ),
                        config.verticalSpaceMedium(),
                        PrimaryFormField(
                          hintIcon: _buildFormFieldIcon(Icons.person_outline),
                          validator: (value) => Validator.validateEmpty(value!),
                          label: '${"First Name"} *',
                          hintTxt: "Jaison",
                          onSaved: (value) {
                            registerParams.firstName = value;
                          },
                        ),
                        config.verticalSpaceMedium(),
                        PrimaryFormField(
                          hintIcon: _buildFormFieldIcon(Icons.person_outline),
                          validator: (value) => Validator.validateEmpty(value!),
                          label: '${"last Name"} *',
                          hintTxt: "Josh",
                          onSaved: (value) {
                            registerParams.lastName = value;
                          },
                        ),
                        config.verticalSpaceMedium(),
                        PrimaryFormField(
                          hintIcon: _buildFormFieldIcon(Icons.mail),
                          validator: (value) => Validator.validateEmail(value!),
                          label: '${"E-mail"} *',
                          hintTxt: "example@gmail.com",
                          onSaved: (value) {
                            registerParams.email = value;
                          },
                        ),
                        config.verticalSpaceMedium(),
                        PrimaryFormField(
                          hintIcon: _buildFormFieldIcon(Icons.lock),
                          isPassword: true,
                          validator: (value) =>
                              Validator.validatePassword(value!),
                          label: '${"Password"} *',
                          hintTxt: "***********",
                          onSaved: (value) {
                            registerParams.password = value;
                          },
                        ),
                        config.verticalSpaceMedium(),
                        PrimaryFormField(
                          hintIcon: _buildFormFieldIcon(Icons.lock),
                          validator: (value) => Validator.validateEmpty(value!),
                          isPassword: true,
                          label: '${"ConfirmPassword"} *',
                          hintTxt: "***********",
                          onSaved: (value) {
                            registerParams.password2 = value;
                          },
                        ),
                        config.verticalSpaceMedium(),
                        PrimaryFormField(
                          hintIcon: _buildFormFieldIcon(Icons.phone_android),
                          validator: (value) =>
                              Validator.validateMobile(value!),
                          keyboardType: TextInputType.phone,
                          label: '${"PhoneNumber"} *',
                          onSaved: (value) {
                            registerParams.contactNumber = value;
                          },
                        ),
                        config.verticalSpaceMedium(),
                        Row(
                          children: const [
                            Text(
                              '${"Position"} *',
                            ),
                          ],
                        ),
                        config.verticalSpaceMedium(),
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
                              items: positionList.map((String positionList) {
                                return DropdownMenuItem(
                                  value: positionList,
                                  child: Text(positionList),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropDownvalue = value;
                                  registerParams.position =
                                      dropDownvalue.toString();
                                  // purchaseOrderParams
                                });
                              },
                            ),
                          ),
                        ),
                        config.verticalSpaceMedium(),
                        Align(
                          alignment: Alignment.topRight,
                          child: PrimaryTextButton(
                            isSmallButton: false,
                            labelColor: Colors.black.withOpacity(0.7),
                            label: 'Login ?',
                            onPressed: () {
                              Get.toNamed(Routes.login);
                            },
                          ),
                        ),
                        config.verticalSpaceMedium(),
                        PrimaryButton(
                            label: "Sign up",
                            onPressed: () {
                              registerFormKey.currentState?.save();

                              if (registerFormKey.currentState?.validate() ==
                                  true) {
                                Get.find<RegisterController>()
                                    .requestRegister(registerParams, context);
                              }
                            }),
                      ],
                    ),
                  );
                }),
              );
            });
          },
        ),
      ),
    );
  }

  Icon _buildFormFieldIcon(IconData iconData) {
    return Icon(
      iconData,
    );
  }
}
