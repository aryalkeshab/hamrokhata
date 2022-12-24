import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/commons/utils/SpUtils.dart';
import 'package:hamrokhata/commons/utils/storage_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  TextEditingController usernameController = TextEditingController(text: '');

  void setPrintingMode(String username) {
    SPUtil.writeString(Constants.username, username);
    update();
  }
}
