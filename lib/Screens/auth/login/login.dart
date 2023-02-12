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
            child: GetBuilder<LoginController>(
              builder: (controller) {
                return HookBaseWidget(
                  builder: (context, config, theme) {
                    final _loginFormKey = useMemoized(GlobalKey<FormState>.new);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 5,
                          color: const Color.fromARGB(255, 171, 211, 250)
                              .withOpacity(0.4),
                          child: Form(
                            key: _loginFormKey,
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
                                    child: const Text(
                                      "Please Login to continue",
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 0.5),
                                    ),
                                  ),
                                  config.verticalSpaceMedium(),
                                  FadeAnimation(
                                    delay: 1,
                                    child: PrimaryFormField(
                                      hintIcon: const Icon(
                                        Icons.email,
                                        color: Colors.white,
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
                                      hintIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      validator: (value) =>
                                          Validator.validatePassword(value!),
                                      onSaved: (value) {
                                        loginParams.password = value;
                                      },
                                      hintTxt: "*********",
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
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        config.verticalSpaceSmall(),
                        FadeAnimation(
                          delay: 1,
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.pop(context);
                              Get.toNamed(Routes.forgotPasswordScreen);
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) {
                              //   return ForgotPasswordScreen();
                              // }));
                            }),
                            child: Text("Can't Log In?",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 0.5,
                                )),
                          ),
                        ),
                        config.verticalSpaceSmall(),
                        FadeAnimation(
                          delay: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.toNamed(Routes.register);
                                },
                                child: Text("Sign up",
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
                  },
                );
              },
            ),
          ),
        ),
      ),
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
