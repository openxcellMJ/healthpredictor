import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as MyPermissionStatus;
import '../../../data/remote/network_data_source.dart';
import '../../../main.dart';
import '../../../preferences/preference_utils.dart';
import '../../../utils/utils.dart';
import '../../pages/main/home.dart';

class SplashController extends GetxController {
  navigateToScreen() {
    Future.delayed(const Duration(seconds: 5), () async {
      Get.offAll(const HomePage());
    });
  }
}
