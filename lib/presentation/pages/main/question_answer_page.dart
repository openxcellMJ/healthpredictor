


import 'package:envitely/presentation/controller/main/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../values/app_colors.dart';

class QuestionAnswerPage extends GetView<HomeController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: AppBar(
          backgroundColor: AppColors.gradientStart,
          centerTitle: true,
          title: const Text(
            "Chat With Me",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),);
  }
}