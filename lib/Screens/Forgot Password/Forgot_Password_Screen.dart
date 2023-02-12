import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/Forgot%20Password/forget_password_controller.dart';

import 'package:hamrokhata/commons/Core/Animation/Fade_Animation.dart';
import 'package:hamrokhata/commons/Core/Colors/Hex_Color.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/models/request/forget_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Pin Code/Pin_Code_Screen.dart';

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [
              HexColor("#4b4293").withOpacity(0.8),
              HexColor("#4b4293"),
              HexColor("#08418e"),
              HexColor("#08418e")
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
          child: GetBuilder<ForgetPasswordController>(builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    color: const Color.fromARGB(255, 171, 211, 250)
                        .withOpacity(0.4),
                    child: Form(
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
                                child: Text(
                                  "Let us help you",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
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
                                  hintIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
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
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF2697FF),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0, horizontal: 80),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0))),
                                onPressed: () {
                                  // Navigator.pop(context);
                                  // Navigator.of(context)
                                  //     .push(MaterialPageRoute(builder: (context) {
                                  //   return PinCodeVerificationScreen(
                                  //     email: '0102756960',
                                  //   );
                                  // }));

                                  final currentState = formKey.currentState;
                                  // if (currentState != null) {
                                  //   currentState.save();
                                  //   if (currentState.validate()) {
                                  //     setState(
                                  //       () {
                                  controller.forgetPasswordVerify(
                                      forgetPasswordParams, context);
                                  //       },
                                  //     );
                                  //   } else {
                                  //     errorController!
                                  //         .add(ErrorAnimationType.shake);
                                  //   }
                                  // }
                                },
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //End of Center Card
                  //Start of outer card
                  const SizedBox(
                    height: 20,
                  ),

                  FadeAnimation(
                    delay: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Want to try again? ",
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
              ),
            );
          }),
        ),
      ),
    );
  }
}
