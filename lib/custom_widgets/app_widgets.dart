import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/utils.dart';
import '../values/app_colors.dart';
import '../values/app_images.dart';
import '../values/font_manager.dart';

class AppWidgets {
  static AppBar appBar(bool isBack, {String? title, Widget? titleView, List<Widget>? actions, var color = Colors.transparent, TextStyle? style, PreferredSizeWidget? tabLayout, Function()? onBack, SystemUiOverlayStyle? systemOverlayStyle}) {
    return AppBar(
      leading: Visibility(
        visible: isBack,
        child: IconButton(
            color: Colors.black,
            icon: SvgPicture.asset(AppImage.icArrowBack),
            iconSize: 20.0,
            onPressed: onBack ??
                () {
                  Utils.isFromHideKeyboard = false;
                  Get.back();
                }),
      ),
      automaticallyImplyLeading: true,
      scrolledUnderElevation: 0,
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: color,
      actions: actions,
      title: titleView ??
          Text(
            title ?? "",
            style: style ?? Get.theme.textTheme.displayLarge?.copyWith(fontSize: 20, color: AppColors.gradientMiddle),
          ),
      bottom: tabLayout,
    );
  }

  static Widget divider() {
    return const Divider(
      height: 0.5,
      color: AppColors.dividerLineColor,
    );
  }

  static Widget buttonsDialog(LinearGradient linerGradients, String title, Function()? onClick) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: linerGradients,
      ),
      padding: EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: onClick,
        style: Get.theme.elevatedButtonTheme.style?.copyWith(shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0)))), backgroundColor: const MaterialStatePropertyAll(Colors.transparent)),
        child: Text(
          title,
          style: Get.theme.textTheme.displayMedium?.copyWith(
            color: AppColors.colorWhite,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  static Widget setElevatedButton(String? btnText, Function()? onClick, {double padding = 8, TextStyle? styles, EdgeInsets? marginContainer}) {
    return Container(
      margin: marginContainer ?? const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(
          btnText ?? "",
          style: styles,
        ),
      ),
    );
  }

  static Widget setTextButton(String? btnText, Function()? onClick, {double padding = 8, TextStyle? styles, EdgeInsets? marginContainer}) {
    return Container(
      margin: marginContainer ?? const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      width: double.infinity,
      child: TextButton(
        onPressed: onClick,
        child: Text(
          btnText ?? "",
          style: styles,
        ),
      ),
    );
  }

  static Widget setElevatedOutlineButton(String? btnText, Function()? onClick, {double padding = 8, TextStyle? styles, EdgeInsets? marginContainer}) {
    return Container(
      width: double.infinity,
      margin: marginContainer ?? EdgeInsets.only(top: 10.h, bottom: 10.h, left: 20.w, right: 20.w),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),color: AppColors.gradientMiddle
      ),
      child: OutlinedButton(
        onPressed: onClick,
        style: Get.theme.outlinedButtonTheme.style?.copyWith(shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius:
        BorderRadius.all(Radius.circular(0))))),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          child: setTextWidget(btnText ?? "", lines: 2, styles: styles ?? Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.gradientMiddle,

              fontSize: 14)),
        ),
      ),
    );
  }

  static Widget setTextWidget(String text, {int lines = 1, TextAlign align = TextAlign.left, TextOverflow overflows = TextOverflow.visible, TextStyle? styles}) {
    return Text(
      text,
      textAlign: align,
      maxLines: lines,
      overflow: overflows,
      style: styles,
    );
  }

  static Widget setElevatedButtonNew(String? btnText, Function()? onClick, {double padding = 8, TextStyle? styles, EdgeInsets? marginContainer}) {
    return Container(
      margin: marginContainer ?? EdgeInsets.only(top: 10.h, bottom: 10.h, left: 20.w, right: 20.w),
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
      child: ElevatedButton(
        onPressed: onClick,
        style: Get.theme.elevatedButtonTheme.style?.copyWith(shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0)))), backgroundColor: const MaterialStatePropertyAll(Colors.transparent)),
        child: Text(
          btnText ?? "",
          style: styles ?? Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.colorWhite, fontSize: 14.sp),
        ),
      ),
    );
  }

  static Widget setElevatedWithIconButton(String? btnText, Function()? onClick, String icon, {double padding = 20, TextStyle? styles, Color? color}) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: padding, right: padding),
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: AppImage.loadSVG(icon, height: 20, width: 20, color: color),
        onPressed: onClick,
        label: Text(
          btnText ?? "",
          style: styles,
        ),
      ),
    );
  }

  static Widget setOutlineButtonWithIconButton(String? btnText, Function()? onClick, String icon, {double padding = 8, TextStyle? styles, bool isDisable = false, double bottomPadding = 20}) {
    return Container(
      margin: EdgeInsets.only(left: padding, right: padding, top: 20, bottom: bottomPadding),
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onClick,
        style: Get.theme.outlinedButtonTheme.style?.copyWith(
          //backgroundColor: MaterialStateProperty.all(isDisable ? AppColors.disableButtonBackground : AppColors.colorWhite),
          side: MaterialStateProperty.all(BorderSide(color: isDisable ? AppColors.disableButtonBackground : AppColors.orange)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage.loadSVG(icon, width: 20, height: 20, color: isDisable ? AppColors.disableButtonText : AppColors.orange),
              const SizedBox(
                width: 8,
              ),
              setTextWidget(btnText ?? "", lines: 2, styles: styles ?? Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.orange, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  static Widget setOutlineButtonWithIconButtonForSocialLogin(String? btnText, Function()? onClick, String icon, {double padding = 8, TextStyle? styles, bool isDisable = false}) {
    return Container(
      margin: EdgeInsets.only(left: padding, right: padding, top: 10, bottom: 10),
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onClick,
        style: Get.theme.outlinedButtonTheme.style?.copyWith(
          //backgroundColor: MaterialStateProperty.all(isDisable ? AppColors.disableButtonBackground : AppColors.colorWhite),
          side: MaterialStateProperty.all(BorderSide(color: isDisable ? AppColors.disableButtonBackground : AppColors.socialBackground)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage.loadSVG(
                icon,
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 15,
              ),
              setTextWidget(btnText ?? "", lines: 2, styles: styles ?? Get.theme.textTheme.displayMedium?.copyWith(color: isDisable ? AppColors.disableButtonText : AppColors.socialTextColor, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  static Widget setOutlineButtonWithIconEndButton(String? btnText, Function()? onClick, String icon, {double padding = 8, TextStyle? styles}) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              setTextWidget(btnText ?? "", lines: 1, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.orange, fontSize: 14.sp)),
              const SizedBox(
                width: 8,
              ),
              AppImage.loadSVG(icon, width: 20, height: 20, color: AppColors.orange),
            ],
          ),
        ),
      ),
    );
  }

  static Widget setEmptyView(String title, String icon, String subtitle, {double padding = 8, TextStyle? styles}) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImage.loadSVG(icon, width: 60, height: 60),
          const SizedBox(
            height: 8,
          ),
          Padding(padding: const EdgeInsets.only(left: 20, right: 20), child: setTextWidget(title, lines: 2, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFontSubTitle, fontSize: 16.sp))),
          const SizedBox(
            height: 4,
          ),
          Padding(padding: const EdgeInsets.only(left: 20, right: 20), child: setTextWidget(subtitle, lines: 2, styles: Get.theme.textTheme.displaySmall?.copyWith(color: AppColors.blackFontSubTitle, fontSize: 14.sp))),
        ],
      ),
    );
  }

  static Widget spanStringWithPrimaryColor(String startText, String spanText, {Color? color = AppColors.orange}) {
    return Text.rich(TextSpan(text: startText, style: Get.theme.textTheme.displaySmall?.copyWith(color: AppColors.blackFontSubTitle, fontSize: 14.sp), children: <InlineSpan>[
      TextSpan(
        text: spanText,
        style: Get.theme.textTheme.displayLarge?.copyWith(color: color, fontSize: 14),
      ),
    ]));
    ;
  }

  static Widget setTextWidgetBoldTitle(String text, {Color textColor = AppColors.blackFont, double size = 14, int maxLines = 1}) {
    return Text(text, textAlign: TextAlign.left, maxLines: maxLines, style: Get.theme.textTheme.titleLarge?.copyWith(color: textColor, fontSize: size));
  }

  static Widget setTextWidgetSubTitle(String text) {
    return Text(text, textAlign: TextAlign.left, maxLines: 3, style: Get.theme.textTheme.titleMedium?.copyWith(color: AppColors.blackFontSubTitle, fontSize: 12.sp));
  }

  static Widget setTextWidgetTitle(String text) {
    return Text(text, textAlign: TextAlign.left, maxLines: 2, style: Get.theme.textTheme.displayLarge?.copyWith(fontSize: 24));
  }

  static void setBottomSheet(String title, {required List<Widget> widgets, required Function() onClick, bool isEnableDrag = false, String? btnText, bool isScrollControlled = false, bool isCrossShown = true, bool isDividerShown = true}) {
    Get.bottomSheet(
        backgroundColor: Colors.white,
        enableDrag: isEnableDrag,
        isScrollControlled: isScrollControlled,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 4,
                color: AppColors.dividerColor,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  isCrossShown
                      ? GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppImage.loadSVGs(AppImage.icCross, width: 24, height: 24))
                      : Container(),
                  title.isNotEmpty ? Expanded(child: Center(child: setTextWidget(title, styles: Get.theme.textTheme.displaySmall))) : Container(),
                ],
              ),
              isDividerShown
                  ? const Divider(
                      height: 2,
                      color: AppColors.dividerLineColor,
                    )
                  : Container(),
              isDividerShown ? const SizedBox(height: 10) : Container(),
              ...widgets,
              const SizedBox(height: 10),
              setElevatedButton(btnText, onClick, styles: Get.theme.textTheme.titleMedium?.copyWith(color: AppColors.colorWhite))
            ],
          ),
        ));
  }

  static void setMyBottomSheet(String title, {required List<Widget> widgets, required Function() onClick, bool isEnableDrag = false, String? btnText, bool isScrollControlled = false, bool isCrossShown = true, bool isDividerShown = true, double margin = 10}) {
    Get.bottomSheet(
        backgroundColor: Colors.white,
        enableDrag: isEnableDrag,
        isScrollControlled: isScrollControlled,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        Container(
          margin: EdgeInsets.all(margin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 4,
                color: AppColors.dividerColor,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  isCrossShown
                      ? GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppImage.loadSVGs(AppImage.icCross, width: 24, height: 24))
                      : Container(),
                  title.isNotEmpty ? Expanded(child: Center(child: setTextWidget(title, styles: Get.theme.textTheme.displayLarge?.copyWith(fontSize: 16)))) : Container(),
                ],
              ),
              isDividerShown
                  ? const Divider(
                      height: 2,
                      color: AppColors.dividerLineColor,
                    )
                  : Container(),
              isDividerShown ? const SizedBox(height: 10) : Container(),
              ...widgets,
              const SizedBox(height: 10),
              setElevatedButton(btnText, onClick, styles: Get.theme.textTheme.titleMedium?.copyWith(color: AppColors.colorWhite))
            ],
          ),
        ));
  }

  static void setMyCancellationBottomSheet(String title, {required List<Widget> widgets, required Function() onClick, bool isEnableDrag = false, String? btnText, bool isScrollControlled = false, bool isCrossShown = true, bool isDividerShown = true, double margin = 10}) {
    Get.bottomSheet(
        backgroundColor: Colors.white,
        enableDrag: isEnableDrag,
        isScrollControlled: isScrollControlled,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 4,
                color: AppColors.dividerColor,
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  isCrossShown
                      ? GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 5),
                            child: AppImage.loadSVGs(AppImage.icCross, width: 24, height: 24),
                          ))
                      : Container(),
                  title.isNotEmpty
                      ? Row(
                          children: [
                            Expanded(child: Center(child: setTextWidget(title, styles: Get.theme.textTheme.displayLarge?.copyWith(fontSize: 16)))),
                          ],
                        )
                      : Container(),
                ],
              ),
              isDividerShown
                  ? const Divider(
                      height: 2,
                      color: AppColors.dividerLineColor,
                    )
                  : Container(),
              ...widgets,
              const SizedBox(height: 10),
              setElevatedButton(btnText, onClick, styles: Get.theme.textTheme.titleMedium?.copyWith(color: AppColors.colorWhite))
            ],
          ),
        ));
  }

  static showExitAppDialog() {
    Get.dialog(AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: AppWidgets.setTextWidget('strSureWantToExit'.tr, lines: 3, align: TextAlign.center, styles: Get.theme.textTheme.displaySmall?.copyWith(color: AppColors.blackFontTitle, fontSize: 18)),
          ),
          const SizedBox(height: 24),
          AppWidgets.setElevatedButton('strConfirm'.tr, () {
            if (Platform.isAndroid) {
              exit(0);
            } else if (Platform.isIOS) {
              exit(0);
            }
          }),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: AppWidgets.setTextWidget('strCancel'.tr, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.orange, fontSize: 14)),
          ),
          const SizedBox(height: 10)
        ],
      ),
      alignment: Alignment.center,
    ));
  }

  static showCheckInSuccessfulDialog(Function() okayClicked) {
    Get.dialog(AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: AppWidgets.setTextWidget('strCheckInSuccessful'.tr, lines: 3, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFontTitle, fontSize: 22)),
          ),
          const SizedBox(height: 10),
          Center(
            child: AppWidgets.setTextWidget('strCheckInSuccessfulDesc'.tr, lines: 3, styles: Get.theme.textTheme.displaySmall?.copyWith(color: AppColors.blackFontTitle, fontSize: 14)),
          ),
          const SizedBox(height: 24),
          AppWidgets.setElevatedButton('strOk'.tr, () {
            Get.back();
            okayClicked();
          }),
          const SizedBox(height: 10)
        ],
      ),
      alignment: Alignment.center,
    ));
  }

  static Widget buildRadioListTile({
    String? title,
    TextStyle? txtStyles,
    dynamic value,
    dynamic groupValue,
    required ValueChanged<dynamic> onChanged,
  }) {
    return RadioListTile(
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      title: setTextWidget(title ?? "",
          align: TextAlign.left,
          styles: txtStyles ??
              Get.theme.textTheme.titleMedium?.copyWith(
                color: AppColors.blackFontTitle,
                fontWeight: FontWeightManager.regular,
                fontSize: 14.sp,
              )),
      value: value,
      controlAffinity: ListTileControlAffinity.trailing,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }

  //    Obx(() => AppWidgets.buildRadioListTile(
  //                   context,
  //                   title: "Male",
  //                   txtStyles: context.theme.textTheme.displaySmall,
  //                   groupValue: selectedValue.value,
  //                   value: 2,
  //                   onChanged: (value) {
  //                     selectedValue.value = value;
  //                     print("test=>${selectedValue}=>${value}");
  //                   },
  //                 )),

  //https://editor.lottiefiles.com/?fileUrl=https://assets6.lottiefiles.com/packages/lf20_f1dhzsnx.json&origin=web&hash=OTU0OTQtZG91YmxlLWxvYWRlcg==&src=https://lottiefiles.com/upload-file/editor
  // static void showProgress() {
  //   Future.delayed(Duration.zero, () async {
  //     Get.dialog(
  //         barrierDismissible: false,
  //         Center(
  //           child: OverflowBox(
  //               minHeight: 110,
  //               maxHeight: 110,
  //               child: Stack(
  //                 children: [
  //                   Lottie.asset(AppImage.icAppLoader),
  //                   Positioned.fill(
  //                       child: Align(
  //                           alignment: Alignment.center,
  //                           child: Image.asset(
  //                             AppImage.icAppLogoRound,
  //                             width: 45,
  //                             height: 45,
  //                           ))),
  //                 ],
  //               )),
  //         ));
  //   });
  // }
  static void closeProgress() {
    if (Utils.isProgressShown) {
      Get.back();
    }
  }

  static void showProgress() {
    Future.delayed(Duration.zero, () async {
      if (!Utils.isProgressShown) {
        Utils.isProgressShown = true;
        Get.dialog(
            barrierDismissible: false,
            Center(
              child: Lottie.asset(AppImage.icAppLoader, width: 180, height: 180),
            )).then((_isOpen) {
          Utils.isProgressShown = false;
        });
      }
    });
  }

  // static void showProgress() {
  //   Future.delayed(Duration.zero, () async {
  //     Get.dialog(
  //         barrierDismissible: false,
  //         Center(
  //           child: Lottie.asset(AppImage.icAppLoader, width: 180, height: 180),
  //         ));
  //   });
  // }

  static void showSnackBar(String message, {Color? color}) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: setTextWidget(message, styles: Get.theme.snackBarTheme.contentTextStyle, lines: 3),
        message: message,
        isDismissible: true,
        borderRadius: 5,
        backgroundColor: color ?? Get.theme.snackBarTheme.backgroundColor!,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Widget defaultPadding({double leftValue = 20, double rightValue = 20}) {
    return Container(
      padding: EdgeInsets.only(left: leftValue, right: rightValue),
    );
  }

  static Widget createSettingMenu(String title, BuildContext context, {bool showDivider = true, Function()? onTap, double? width, bool showImage = true, String? image}) {
    return Column(
      children: [
        Visibility(
          visible: showDivider,
          child: Container(
            width: width ?? (MediaQuery.of(context).size.width) - 50,
            height: 1,
            color: AppColors.dividerLineColor,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.only(top: 22, bottom: 22, left: 20, right: 20),
            color: AppColors.colorWhite,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Visibility(visible: showImage, child: AppImage.loadSVG(image ?? "", width: 24, height: 24)),
                Visibility(
                  visible: showImage,
                  child: const SizedBox(
                    width: 16,
                  ),
                ),
                Expanded(child: AppWidgets.setTextWidget(title, lines: 2, styles: Get.theme.textTheme.displaySmall?.copyWith(color: AppColors.blackFontSubTitle, fontSize: 14))),
                Align(alignment: Alignment.centerRight, child: AppImage.loadSVG(AppImage.icRight, width: 24, height: 24)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget settingMenu(String title, BuildContext context, {Function()? onTap, double? width, bool showImage = true, String? image}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Visibility(visible: showImage, child: AppImage.loadSVG(image ?? "", width: 30, height: 30)),
            Visibility(
              visible: showImage,
              child: const SizedBox(
                width: 16,
              ),
            ),
            Expanded(child: AppWidgets.setTextWidget(title, lines: 2, styles: Get.theme.textTheme.titleMedium?.copyWith(color: AppColors.blackFontSubTitle, fontSize: 14))),
            Align(alignment: Alignment.centerRight, child: AppImage.loadSVG(AppImage.icRight, width: 24, height: 24)),
          ],
        ),
      ),
    );
  }

  static Widget checkCheckBox({required bool value, required ValueChanged<dynamic> onChanged}) {
    return Transform.scale(
      scale: 1.4,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  static Widget ovalCircle({required double size, Color? bgColor}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.orange,
        shape: BoxShape.circle,
      ),
    );
  }

  static Widget ovalCircleWithText({required double size, Color? bgColor, Widget? textView}) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.orange,
        shape: BoxShape.circle,
      ),
      padding: textView != null ? const EdgeInsets.all(5) : null,
      child: textView ?? const SizedBox(),
    );
  }

  static Widget badgeRadiusRoundWithText({Color? bgColor, Widget? textView, BorderRadius? radiusRound, double? height, double? width}) {
    return Container(
      width: width ?? null,
      height: height ?? null,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.orange,
        borderRadius: radiusRound ??
            const BorderRadius.all(
              Radius.circular(
                6,
              ),
            ),
      ),
      padding: textView != null ? const EdgeInsets.symmetric(vertical: 2, horizontal: 5) : null,
      child: textView ?? const SizedBox(),
    );
  }

  static Widget containerBG({Color? bgColor, Color? stokeColor, double? radiusRound, Widget? childWidget, EdgeInsets? marginContainer, EdgeInsets? paddingContainer, double? widthContainer}) {
    return Container(
      width: widthContainer,
      margin: marginContainer ?? null,
      padding: paddingContainer ?? null,
      decoration: BoxDecoration(
          color: bgColor ?? AppColors.disableGrayBG,
          borderRadius: BorderRadius.all(
            Radius.circular(
              radiusRound ?? 6,
            ),
          ),
          border: Border.all(width: 1, color: stokeColor ?? bgColor ?? AppColors.disableGrayBG)),
      child: childWidget ?? const SizedBox(),
    );
  }
}
