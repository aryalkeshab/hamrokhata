import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/Forgot%20Password/forget_password_controller.dart';
import 'package:hamrokhata/commons/resources/colors.dart';

import 'package:hamrokhata/commons/Core/Animation/Fade_Animation.dart';
import 'package:hamrokhata/commons/Core/Colors/Hex_Color.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/models/request/forget_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../commons/widgets/buttons.dart';

enum FormData { Email }

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;

  FormData? selected;

  TextEditingController emailController = new TextEditingController();
  final ForgetPasswordParams forgetPasswordParams = ForgetPasswordParams();
  StreamController<ErrorAnimationType>? errorController;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    return Scaffold(
      body: BaseWidget(builder: (context, config, theme) {
        return Container(
          color: Color.fromARGB(255, 238, 235, 235),
          padding: EdgeInsets.symmetric(
              horizontal: config.appHorizontalPaddingMedium()),
          child: Center(
            child: GetBuilder<ForgetPasswordController>(builder: (controller) {
              return SingleChildScrollView(
                child: Card(
                  elevation: 20,
                  shadowColor: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: formKey,
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
                              const SizedBox(
                                height: 10,
                              ),
                              FadeAnimation(
                                delay: 1,
                                child: Container(
                                  child: const Text(
                                    "Let us help you,",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                delay: 1,
                                child: FadeAnimation(
                                  delay: 1,
                                  child: PrimaryFormField(
                                    hintIcon: Icon(
                                      Icons.email,
                                      color: primaryColor,
                                    ),
                                    validator: (value) =>
                                        Validator.validateEmail(value!),
                                    onSaved: (value) {
                                      forgetPasswordParams.email = value;
                                    },
                                    onChanged: (value) {
                                      forgetPasswordParams.email = value;
                                    },
                                    hintTxt: "example@gmail.com",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              FadeAnimation(
                                delay: 1,
                                child: PrimaryButton(
                                    label: "Continue",
                                    onPressed: () {
                                      controller.forgetPasswordVerify(
                                          forgetPasswordParams, context);
                                    }),
                              ),
                            ],
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
                            const Text("Want to try again? ",
                                style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                )),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.login);
                              },
                              child: Text("Sign in",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      fontSize: 14)),
                            ),
                          ],
                        ),
                      ),
                      config.verticalSpaceMedium(),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
