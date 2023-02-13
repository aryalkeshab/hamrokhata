import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/commons/api/storage_constants.dart';
import 'package:hamrokhata/commons/resources/ui_assets.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GetBuilder<SplashAnimationController>(
        init: SplashAnimationController(),
        builder: (controller) {
          return Stack(
            fit: StackFit.loose,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    UIAssets.appLogo,
                    filterQuality: FilterQuality.high,
                    width: controller.animation.value * 500,
                    height: controller.animation.value * 550,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class SplashAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final secureStorage = Get.find<FlutterSecureStorage>();

  @override
  void onInit() {
    initAnimation();
    // Get.toNamed(Routes.onBoarding);

    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    initPackageInfo();

    super.dispose();
  }

  initAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)
            .obs
            .value;
    animation.addListener(() => update());
    animationController.forward().whenComplete(() async {
      // if (await storage.read(key: StorageConstants.accessToken))
      // Get.offAllNamed(Routes.introScreen);

      Timer(const Duration(seconds: 1), () async {
        final accessToken =
            await secureStorage.read(key: StorageConstants.accessToken);
        final isLoggedIn =
            await secureStorage.read(key: StorageConstants.isLoggedIn);
        final introPageDone =
            await secureStorage.read(key: StorageConstants.introPageDone);
        print(introPageDone);

        if (introPageDone == "false" || accessToken == null) {
          Get.offNamed(Routes.introScreen);
        } else if (accessToken.isNotEmpty || isLoggedIn == "true") {
          Get.offNamed(Routes.dashboard);
        } else {
          Get.offNamed(Routes.login);
        }

        // if (secureStorage.instance.sharedPref.getOnBordingValue == false) {
        //   if (UserController.instance.sharedPref.getLoginReminder == false) {
        //     Get.offNamed(LoginScreen.routeName);
        //   } else {
        //     Get.offNamed(HomeScreen.routeName);
        //   }
        // } else {
        //   Get.offNamed(OnBoardingScreen.routeName);
        // }
      });
    });
  }

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    // setState(() {
    packageInfo = info;
    update();
    // });
  }
}
