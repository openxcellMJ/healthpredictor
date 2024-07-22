import 'package:envitely/presentation/controller/main/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/app_widgets.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_images.dart';
import 'question_answer_page.dart';

class FormAnswerPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      controller.result.value = Get.arguments;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: AppBar(
          leading: IconButton(
              color: Colors.black,
              icon: SvgPicture.asset(AppImage.icArrowBack),
              iconSize: 20.0,
              onPressed: () {
                Get.back();
              }),
          automaticallyImplyLeading: true,
          scrolledUnderElevation: 0,
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(QuestionAnswerPage());
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                child: Text(
                  "Q & A",
                  style: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.colorWhite, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
          title: Text(
            'Result',
            style: Get.theme.textTheme.displayLarge?.copyWith(fontSize: 20, color: AppColors.gradientMiddle),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(15),
              child: Obx(
                () => AppWidgets.setTextWidget(controller.result.value, align: TextAlign.start, lines: 10000, styles: Get.theme.textTheme.displayMedium?.copyWith(color: AppColors.blackFont, fontSize: 15)),
              )),
        ),
      ),
    );
  }
}
