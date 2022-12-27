import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/SpUtils.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';
import 'package:hamrokhata/commons/utils/storage_constants.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';
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

  Widget build(BuildContext context) {

      final authController = Get.put(AuthController());

    return Scaffold(
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return HookBaseWidget(
            builder: (context, config, theme) {
              final loginFormKey = useMemoized(GlobalKey<FormState>.new);
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: config.appHorizontalPaddingLarge(),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/images/app_logo.png"),
                      ),
                      config.verticalSpaceMedium(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: loginFormKey,
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PrimaryFormField(
                                  hintIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey[600],
                                  ),
                                  label: "Username",
                                  validator: (value) =>
                                      Validator.validateEmail(value!),
                                  onSaved: (value) {
                                    // loginParams.email = value;
                                  },
                                  controller: authController.usernameController,
                                  hintTxt: "example@gmail.com",
                                ),
                                config.verticalSpaceMedium(),
                                PrimaryFormField(
                                  isPassword: true,
                                  hintIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey[600],
                                  ),
                                  label: "Password",
                                  validator: (value) =>
                                      Validator.validateEmpty(value!),
                                  onSaved: (value) {},
                                  hintTxt: "*********",
                                ),
                                config.verticalSpaceMedium(),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: PrimaryTextButton(
                                    isSmallButton: false,
                                    labelColor: Colors.black.withOpacity(0.7),
                                    label: 'Register ?',
                                    onPressed: () {
                                      Get.toNamed(Routes.register);
                                    },
                                  ),
                                ),
                                config.verticalSpaceSmall(),
                                PrimaryButton(
                                    label: "Login",
                                    onPressed: () {
                                      showSuccessToast(
                                          'Successfully Logged in. ');
                                      SPUtil.writeString(
                                          Constants.username,
                                          authController
                                              .usernameController.text);
                                      Get.toNamed(Routes.dashboard);
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '(Version: ${packageInfo.version})',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15.5,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}
