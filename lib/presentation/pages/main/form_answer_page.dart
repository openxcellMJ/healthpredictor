import 'package:envitely/presentation/controller/main/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/app_widgets.dart';
import '../../../values/app_colors.dart';

class FormAnswerPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      controller.result.value = Get.arguments;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: AppWidgets.appBar(true, title: 'Result'),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(15),
              child: Obx(
                () => AppWidgets.setTextWidget(controller.result.value,
                    align: TextAlign.start, lines: 1000,
                    styles: Get.theme.textTheme.displayMedium?.copyWith(color:
                    AppColors.blackFont, fontSize: 15)),
              )),
        ),
      ),
    );
  }
}
