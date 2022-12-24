import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrokhata/commons/resources/ui_assets.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';

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
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    UIAssets.appLogo,
                    filterQuality: FilterQuality.high,
                    width: controller.animation.value * 500,
                    height: controller.animation.value * 500,
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

  @override
  void onInit() {
    initAnimation();
    // Get.toNamed(Routes.onBoarding);
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
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
    animationController
        .forward()
        .whenComplete(() => Get.offAllNamed(Routes.login));
  }
}
