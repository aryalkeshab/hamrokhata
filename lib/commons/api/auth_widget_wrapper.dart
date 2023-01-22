import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/Screens/auth/auth_controller.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, bool isAuthenticated) builder;

  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => builder(context, Get.find<AuthController>().isLoggedIn.value));
  }
}
