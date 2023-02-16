import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/Forgot%20Password/forget_password_controller.dart';

import 'package:hamrokhata/commons/Core/Animation/Fade_Animation.dart';
import 'package:hamrokhata/commons/Core/Colors/Hex_Color.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
import 'package:hamrokhata/models/request/forget_password.dart';
import 'package:hamrokhata/models/request/reset_password_params.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../commons/widgets/buttons.dart';

class ResetPasswordScreen extends StatefulWidget {
  final int? user_id;
  const ResetPasswordScreen({super.key, this.user_id});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;

  FormData? selected;

  TextEditingController emailController = new TextEditingController();
  final ResetPasswordParams resetPasswordParams = ResetPasswordParams();
  StreamController<ErrorAnimationType>? errorController;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    resetPasswordParams.user_id = widget.user_id;
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 156, 79, 16),
        child: Center(
          child: GetBuilder<ForgetPasswordController>(builder: (controller) {
            return BaseWidget(builder: (context, config, theme) {
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
                                child: PrimaryFormField(
                                  isPassword: true,
                                  hintIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  validator: (value) =>
                                      Validator.validatePassword(value!),
                                  onSaved: (value) {
                                    resetPasswordParams.newPassword = value;
                                  },
                                  hintTxt: "New Password",
                                ),
                              ),
                              config.verticalSpaceMedium(),
                              FadeAnimation(
                                delay: 1,
                                child: PrimaryFormField(
                                  isPassword: true,
                                  hintIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  validator: (value) =>
                                      Validator.validatePassword(value!),
                                  onSaved: (value) {
                                    resetPasswordParams.confirmNewPassword =
                                        value;
                                  },
                                  hintTxt: "Confirm New Password",
                                ),
                              ),
                              config.verticalSpaceMedium(),
                              FadeAnimation(
                                delay: 1,
                                child: PrimaryButton(
                                    // width: 40,
                                    // height: 25,
                                    label: "Change Password",
                                    onPressed: () async {
                                      if (resetPasswordParams
                                              .confirmNewPassword !=
                                          resetPasswordParams.newPassword) {
                                        showErrorToast(
                                            "New Password and Confirm Password does not match");
                                      } else {
                                        final currentState =
                                            formKey.currentState;
                                        if (currentState != null) {
                                          currentState.save();

                                          if (currentState.validate()) {
                                            controller.passwordResetAuth(
                                                resetPasswordParams, context);
                                          }
                                        }
                                      }
                                    }),
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
            });
          }),
        ),
      ),
    );
  }
}
