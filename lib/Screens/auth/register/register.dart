import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/register/register_controller.dart';
import 'package:hamrokhata/commons/Core/Animation/Fade_Animation.dart';
import 'package:hamrokhata/commons/Core/Colors/Hex_Color.dart';
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
  List<String> positionList = ["administrator", "staff"];
  String? dropDownvalue;

  @override
  Widget build(BuildContext context) {
    // final authController = Get.put(AuthController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [
              HexColor("#4b4213").withOpacity(0.9),
              HexColor("#4b4293"),
              HexColor("#08428e"),
              HexColor("#08417e")
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                HexColor("#fff").withOpacity(0.2), BlendMode.dstATop),
            image: const NetworkImage(
              'https://quickbooks.intuit.com/oidam/intuit/sbseg/en_us/Blog/Graphic/inventory-management-illustration.png',
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: BaseWidget(
              builder: (context, config, theme) {
                return GetBuilder<RegisterController>(builder: (controller) {
                  return HookBaseWidget(builder: (context, config, theme) {
                    final registerFormKey =
                        useMemoized(GlobalKey<FormState>.new);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 5,
                          color: const Color.fromARGB(255, 171, 211, 250)
                              .withOpacity(0.4),
                          child: Form(
                            key: registerFormKey,
                            child: Container(
                              width: 400,
                              padding: const EdgeInsets.all(40.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FadeAnimation(
                                    delay: 0.8,
                                    child: Image.asset(
                                      "assets/images/app_logo.png",
                                      width: 600,
                                      height: 100,
                                    ),
                                  ),
                                  config.verticalSpaceMedium(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: Container(
                                      child: Text(
                                        "Create your account",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            letterSpacing: 0.5),
                                      ),
                                    ),
                                  ),
                                  config.verticalSpaceMedium(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: PrimaryFormField(
                                      hintIcon: Icon(
                                          color: Colors.white,
                                          Icons.person_outline),
                                      validator: (value) =>
                                          Validator.validateEmpty(value!),
                                      hintTxt: "First Name",
                                      onSaved: (value) {
                                        registerParams.firstName = value;
                                      },
                                    ),
                                  ),
                                  config.verticalSpaceMedium(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: PrimaryFormField(
                                      hintIcon: Icon(
                                          color: Colors.white,
                                          Icons.person_outline),
                                      validator: (value) =>
                                          Validator.validateEmpty(value!),
                                      hintTxt: "Second Name",
                                      onSaved: (value) {
                                        registerParams.lastName = value;
                                      },
                                    ),
                                  ),

                                  config.verticalSpaceMedium(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: PrimaryFormField(
                                      hintIcon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      validator: (value) =>
                                          Validator.validateEmail(value!),
                                      keyboardType: TextInputType.emailAddress,
                                      hintTxt: "xyz@gmail.com",
                                      onSaved: (value) {
                                        registerParams.email = value;
                                      },
                                    ),
                                  ),
                                  config.verticalSpaceMedium(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: PrimaryFormField(
                                      hintIcon: Icon(
                                        Icons.phone_android,
                                        color: Colors.white,
                                      ),
                                      validator: (value) =>
                                          Validator.validateMobile(value!),
                                      keyboardType: TextInputType.phone,
                                      hintTxt: "9812234567",
                                      onSaved: (value) {
                                        registerParams.contactNumber = value;
                                      },
                                    ),
                                  ),
                                  config.verticalSpaceMedium(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: PrimaryFormField(
                                      hintIcon:
                                          Icon(color: Colors.white, Icons.lock),
                                      isPassword: true,
                                      validator: (value) =>
                                          Validator.validatePassword(value!),
                                      hintTxt: 'Password',
                                      onSaved: (value) {
                                        registerParams.password = value;
                                      },
                                    ),
                                  ),
                                  config.verticalSpaceMedium(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: PrimaryFormField(
                                      hintIcon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      validator: (value) =>
                                          Validator.validateEmpty(value!),
                                      isPassword: true,
                                      hintTxt: 'Confirm Password',
                                      onSaved: (value) {
                                        registerParams.password2 = value;
                                      },
                                    ),
                                  ),

                                  config.verticalSpaceMedium(),
                                  // FadeAnimation(
                                  //   delay: 1,
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     children: const [
                                  //       Text(
                                  //         '${"Position"} *',
                                  //         style: TextStyle(color: Colors.white),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // config.verticalSpaceSmall(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border:
                                            Border.all(color: Colors.black54),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: const Text(
                                            '--------Designation-------',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: dropDownvalue,
                                          dropdownColor: Colors.black,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          ),
                                          items: positionList
                                              .map((String positionList) {
                                            return DropdownMenuItem(
                                              value: positionList,
                                              child: Text(
                                                positionList,
                                                selectionColor: Colors.white,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
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
                                  ),
                                  config.verticalSpaceMedium(),
                                  // Align(
                                  //   alignment: Alignment.topRight,
                                  //   child: PrimaryTextButton(
                                  //     isSmallButton: false,
                                  //     labelColor: Colors.black.withOpacity(0.7),
                                  //     label: 'Login ?',
                                  //     onPressed: () {
                                  //       Get.offNamed(Routes.login);
                                  //     },
                                  //   ),
                                  // ),
                                  // config.verticalSpaceMedium(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: PrimaryButton(
                                        label: "Sign up",
                                        onPressed: () {
                                          registerFormKey.currentState?.save();

                                          if (registerFormKey.currentState
                                                  ?.validate() ==
                                              true) {
                                            if (registerParams.password ==
                                                registerParams.password2) {
                                              controller.requestRegister(
                                                  registerParams, context);
                                            } else {
                                              showErrorToast(
                                                  "Password and Confirm password does not match!");
                                              return;
                                            }
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        config.verticalSpaceMedium(),
                        FadeAnimation(
                          delay: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("If you have an account ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.toNamed(Routes.login);
                                },
                                child: Text("Sign in",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                        fontSize: 14)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
                });
              },
            ),
          ),
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
