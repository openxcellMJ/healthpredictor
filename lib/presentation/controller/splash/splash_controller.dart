import 'package:get/get.dart';

import '../../pages/main/home.dart';

class SplashController extends GetxController {
  navigateToScreen() {
    Future.delayed(const Duration(seconds: 5), () async {
      Get.offAll(const HomePage());
    });
  }
}
