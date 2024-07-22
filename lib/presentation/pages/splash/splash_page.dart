import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_images.dart';
import '../../controller/splash/splash_controller.dart';
import '../main/home.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    navigateToScreen();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientMiddle,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage.loadPNG(AppImage.icLogo, width: 150, height: 150, radius: 100),
          ],
        ),
      ),
    );
  }

  navigateToScreen() {
    Future.delayed(const Duration(seconds: 5), () async {
      Get.offAll(const HomePage());
    });
  }
}
