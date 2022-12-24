import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';

import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/models/register_params.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterParams registerParams = RegisterParams();
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: BaseWidget(
          builder: (context, config, theme) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: config.appHorizontalPaddingLarge(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/app_logo.png"),
                  ),
                  config.verticalSpaceMedium(),
                  PrimaryFormField(
                    hintIcon: _buildFormFieldIcon(Icons.person_outline),
                    label: '${"fName"} *',
                    onSaved: (value) {
                      registerParams.firstName = value;
                    },
                  ),
                  config.verticalSpaceMedium(),
                  PrimaryFormField(
                    hintIcon: _buildFormFieldIcon(Icons.person_outline),
                    label: '${"lName"} *',
                    onSaved: (value) {
                      registerParams.lastName = value;
                    },
                  ),
                  config.verticalSpaceMedium(),
                  PrimaryFormField(
                    hintIcon: _buildFormFieldIcon(Icons.mail),
                    label: '${"mail"} *',
                    hintTxt: "example@gmail.com",
                    onSaved: (value) {
                      registerParams.email = value;
                    },
                  ),
                  config.verticalSpaceMedium(),
                  PrimaryFormField(
                    hintIcon: _buildFormFieldIcon(Icons.lock),
                    isPassword: true,
                    validator: (value) => Validator.validatePassword(value!),
                    label: '${"password"} *',
                    hintTxt: "***********",
                    onSaved: (value) {
                      registerParams.password = value;
                    },
                  ),
                  config.verticalSpaceMedium(),
                  PrimaryFormField(
                    hintIcon: _buildFormFieldIcon(Icons.lock),
                    isPassword: true,
                    label: '${"confirmPassword"} *',
                    hintTxt: "***********",
                    onSaved: (value) {},
                  ),
                  config.verticalSpaceMedium(),
                  PrimaryFormField(
                    hintIcon: _buildFormFieldIcon(Icons.phone_android),
                    keyboardType: TextInputType.phone,
                    label: '${"phoneNumber"} *',
                    onSaved: (value) {
                      registerParams.contactNumber = value;
                    },
                  ),
                  config.verticalSpaceMedium(),
                  PrimaryFormField(
                    keyboardType: TextInputType.phone,
                    label: "nId",
                    hintIcon: _buildFormFieldIcon(Icons.person),
                    onSaved: (value) {
                      registerParams.nationalId = value;
                    },
                  ),
                  config.verticalSpaceMedium(),
                  Align(
                    alignment: Alignment.topRight,
                    child: PrimaryTextButton(
                      isSmallButton: false,
                      labelColor: Colors.black.withOpacity(0.6),
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
                        Get.toNamed(Routes.register);
                        print(authController.usernameController.text);
                      }),
                ],
              ),
            );
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
