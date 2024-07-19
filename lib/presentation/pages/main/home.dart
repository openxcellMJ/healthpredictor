import 'dart:io';

import 'package:envitely/presentation/pages/main/report_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/app_widgets.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_images.dart';
import '../../controller/main/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showExitAppDialog();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppWidgets.appBar(false, title: 'appName'.tr),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppWidgets.setTextWidget('strHomeTxt'.tr, align: TextAlign.start, lines: 3, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFontTitle, fontSize: 16.sp)),
                  const SizedBox(height: 10),
                  AppWidgets.setTextWidget('strHomeTxtss'.tr, align: TextAlign.start, lines: 5, styles: Get.theme.textTheme.displaySmall?.copyWith(color: AppColors.lightGray, fontSize: 13.sp)),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Get.to(const ReportFormFiledPage()),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientMiddle,
                            AppColors.gradientEnd,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5), // Shadow color
                            spreadRadius: 5, // Spread radius
                            blurRadius: 7, // Blur radius
                            offset: const Offset(0, 3), // Offset in the x and y direction
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppImage.loadPNG(AppImage.icUploadImage, width: 100, height: 100),
                          const SizedBox(height: 10),
                          AppWidgets.setTextWidget('strFillTheForm'.tr, align: TextAlign.center, lines: 2, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.colorWhite, fontSize: 16.sp)),
                          const SizedBox(height: 5),
                          AppWidgets.setTextWidget('strFillTheFormDes'.tr, align: TextAlign.center, lines: 2, styles: Get.theme.textTheme.displayMedium?.copyWith(color: AppColors.lightGrayColor, fontSize: 12.sp)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(alignment: Alignment.center, child: AppWidgets.setTextWidget('strOr'.tr, align: TextAlign.center, lines: 3, styles: Get.theme.textTheme.displayMedium?.copyWith(color: AppColors.lightGray, fontSize: 14.sp))),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.gradientStart,
                          AppColors.gradientMiddle,
                          AppColors.gradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5), // Shadow color
                          spreadRadius: 5, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: const Offset(0, 3), // Offset in the x and y direction
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImage.loadPNG(AppImage.icFromFill, width: 100, height: 100),
                        const SizedBox(height: 10),
                        AppWidgets.setTextWidget('strUploadReports'.tr, align: TextAlign.center, lines: 2, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.colorWhite, fontSize: 16.sp)),
                        const SizedBox(height: 5),
                        AppWidgets.setTextWidget('strUploadReportsDes'.tr, align: TextAlign.center, lines: 2, styles: Get.theme.textTheme.displayMedium?.copyWith(color: AppColors.lightGrayColor, fontSize: 12.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showExitAppDialog() {
    Get.dialog(AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: AppWidgets.setTextWidget('strSureWantToExit'.tr, align: TextAlign.center, lines: 3, styles: Get.theme.textTheme.displaySmall?.copyWith(color: AppColors.blackFontTitle, fontSize: 16.sp)),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: AppWidgets.setElevatedButton(
                  'strCancel'.tr,
                  () {
                    Get.back();
                  },
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: AppWidgets.setElevatedButton(
                  'strConfirm'.tr,
                  () {
                    if (Platform.isAndroid) {
                      exit(0);
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      alignment: Alignment.center,
    ));
  }
}
