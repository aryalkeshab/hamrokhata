import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/Forgot%20Password/Forgot_Password_Screen.dart';
import 'package:hamrokhata/Screens/auth/login/login_controller.dart';
import 'package:hamrokhata/commons/Core/Animation/Fade_Animation.dart';
import 'package:hamrokhata/commons/Core/Colors/Hex_Color.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/SpUtils.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';

import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/models/request/login_params.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    initPackageInfo();

    super.initState();
  }

  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    setState(() {
      packageInfo = info;
    });
  }

  final LoginParams loginParams = LoginParams();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget(builder: (context, config, theme) {
        return Container(
          color: Color.fromARGB(255, 238, 235, 235),
          padding: EdgeInsets.symmetric(
              horizontal: config.appHorizontalPaddingMedium()),
          child: Center(
            child: SingleChildScrollView(
              child: GetBuilder<LoginController>(
                builder: (controller) {
                  return HookBaseWidget(
                    builder: (context, config, theme) {
                      final _loginFormKey =
                          useMemoized(GlobalKey<FormState>.new);
                      return Card(
                        elevation: 20,
                        shadowColor: Colors.black,
                        // decoration: BoxDecoration(
                        //     border: Border.all(
                        //         width: 6,
                        //         color: Colors.black.withOpacity(0.4))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              key: _loginFormKey,
                              child: Container(
                                width: 400,
                                padding: const EdgeInsets.all(30.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                    // config.verticalSpaceSmall(),
                                    // FadeAnimation(
                                    //   delay: 1,
                                    //   child: Text(
                                    //     "Please Login to Continue",
                                    //     style: TextStyle(
                                    //         color: Colors.black,
                                    //         fontSize: 18,
                                    //         fontWeight: FontWeight.bold,
                                    //         letterSpacing: 0.5),
                                    //   ),
                                    // ),
                                    config.verticalSpaceMedium(),
                                    FadeAnimation(
                                      delay: 1,
                                      child: PrimaryFormField(
                                        hintIcon: Icon(
                                          Icons.email,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        validator: (value) =>
                                            Validator.validateEmail(value!),
                                        onSaved: (value) {
                                          loginParams.email = value;
                                        },
                                        hintTxt: "example@gmail.com",
                                      ),
                                    ),
                                    config.verticalSpaceMedium(),
                                    FadeAnimation(
                                      delay: 1,
                                      child: PrimaryFormField(
                                        isPassword: true,
                                        hintIcon: Icon(
                                          Icons.lock,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        validator: (value) =>
                                            Validator.validatePassword(value!),
                                        onSaved: (value) {
                                          loginParams.password = value;
                                        },
                                        hintTxt: "*********",
                                      ),
                                    ),
                                    config.verticalSpaceSmall(),
                                    FadeAnimation(
                                      delay: 1,
                                      child: GestureDetector(
                                        onTap: (() {
                                          Get.toNamed(
                                              Routes.forgotPasswordScreen);
                                        }),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Text("Forgot Password?",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    config.verticalSpaceMedium(),
                                    FadeAnimation(
                                      delay: 1,
                                      child: PrimaryButton(
                                          label: "Login",
                                          onPressed: () {
                                            final currentState =
                                                _loginFormKey.currentState;
                                            if (currentState != null) {
                                              currentState.save();

                                              if (currentState.validate()) {
                                                Get.find<LoginController>()
                                                    .requestLogin(
                                                        loginParams, context);
                                              }
                                            }

                                            // Get.toNamed(Routes.dashboard);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // config.verticalSpaceSmall(),
                            FadeAnimation(
                              delay: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Don't have an account yet? ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 0.5,
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.register);
                                    },
                                    child: const Text(" Create new",
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
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      }),
      // bottomNavigationBar: Container(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text(
      //       '(Version: ${packageInfo.version})',
      //       textAlign: TextAlign.center,
      //       style: const TextStyle(
      //           fontSize: 15.5,
      //           letterSpacing: 0.5,
      //           fontWeight: FontWeight.w300),
      //     ),
      //   ),
      // ),
    );
  }
}
