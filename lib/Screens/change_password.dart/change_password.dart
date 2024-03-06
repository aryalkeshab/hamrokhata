import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/change_password.dart/change_password_controller.dart';
import 'package:hamrokhata/commons/Core/Animation/Fade_Animation.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/resources/colors.dart';
import 'package:hamrokhata/commons/utils/custom_validators.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';
import 'package:hamrokhata/commons/widgets/buttons.dart';
import 'package:hamrokhata/commons/widgets/textfields.dart';
import 'package:hamrokhata/commons/widgets/toast.dart';

import '../../models/request/change_password_params.dart';

class ChangePasswordScreeen extends StatefulWidget {
  const ChangePasswordScreeen({super.key});

  @override
  State<ChangePasswordScreeen> createState() => _ChangePasswordScreeenState();
}

class _ChangePasswordScreeenState extends State<ChangePasswordScreeen> {
  final ChangePasswordParams changePasswordParams = ChangePasswordParams();
  final secureStorage = Get.find<FlutterSecureStorage>();

  @override
  Widget build(BuildContext context) {
    Get.put(ChangePasswordController());
    return Scaffold(
      appBar: AppBar(title: const Text("Change Your Password")),
      body: GetBuilder<ChangePasswordController>(builder: (controller) {
        return HookBaseWidget(builder: (context, config, theme) {
          final formKey = useMemoized(GlobalKey<FormState>.new);

          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: config.appVerticalPaddingMedium()),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  config.verticalSpaceMedium(),
                  FadeAnimation(
                    delay: 1,
                    child: PrimaryFormField(
                      isPassword: true,
                      hintIcon: Icon(
                        Icons.email,
                        color: primaryColor,
                      ),
                      validator: (value) => Validator.validatePassword(value!),
                      onSaved: (value) {
                        changePasswordParams.oldPassword = value;
                      },
                      hintTxt: "Old Password",
                    ),
                  ),
                  config.verticalSpaceMedium(),
                  FadeAnimation(
                    delay: 1,
                    child: PrimaryFormField(
                      isPassword: true,
                      hintIcon: Icon(
                        Icons.lock,
                        color: primaryColor,
                      ),
                      validator: (value) => Validator.validatePassword(value!),
                      onSaved: (value) {
                        changePasswordParams.newPassword = value;
                      },
                      hintTxt: "New Password",
                    ),
                  ),
                  config.verticalSpaceMedium(),
                  FadeAnimation(
                    delay: 1,
                    child: PrimaryFormField(
                      isPassword: true,
                      hintIcon: Icon(
                        Icons.lock,
                        color: primaryColor,
                      ),
                      validator: (value) => Validator.validatePassword(value!),
                      onSaved: (value) {
                        changePasswordParams.confirmNewPassword = value;
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
                          changePasswordParams.id = await secureStorage.read(
                              key: StorageConstants.loginStaff);
                          // print("-------$userId");

                          // setState(() {
                          //   changePasswordParams.id = userId.toString();
                          // });
                          if (changePasswordParams.confirmNewPassword !=
                              changePasswordParams.newPassword) {
                            showErrorToast(
                                "New Password and Confirm Password does not match");
                          } else {
                            final currentState = formKey.currentState;
                            if (currentState != null) {
                              currentState.save();

                              if (currentState.validate()) {
                                controller.changePasswordVerify(
                                    changePasswordParams, context);
                              }
                            }
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
