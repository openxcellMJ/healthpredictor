import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../values/app_images.dart';
import '../../controller/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.navigateToScreen();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage.loadPNG(AppImage.icLogo, width: 158, height: 158),
          ],
        ),
      ),
    );
  }
}
