import 'package:envitely/values/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppColors {
  static const Color colorBlackBg = Color(0xff161712);
  static const Color colordarkBottomNavigationBar = Color(0xff232323);
  static const Color colorLightBottomNavigationBar = Color(0xffF7F7F7);
  static const Color colorButton = Color(0xff555555);
  static const Color shadowColor = Color(0xffDDDDDD);
  static const Color shadowDarkColor = Color(0xff232323);
  static const Color darkGrey = Color(0xff525252);
  static const Color grey = Color(0xff737477);
  static const Color blackFontTitle = Color(0xff172B4D);
  static const Color blackFontSubTitle = Color(0xff44546F);
  static const Color lightGray = Color(0xff9E9E9E);
  static const Color textFieldBorder = Color(0xffDCDFE4);
  static const Color textFieldErrorBorder = Color(0xffCA3521);
  static const Color textFieldErrorText = Color(0xffAE2A19);
  static const Color primaryOpacity70 = Color(0xB3ED9728);
  static const Color orange = Color(0xffF16524);
  static const Color disableButtonBackground = Color(0xffF1F2F4);
  static const Color disableButtonText = Color(0xffB3B9C4);
  static const Color darkPrimary = Color(0xffd17d11);
  static const Color hintText = Color(0xff758195);
  static const Color grey1 = Color(0xff707070);
  static const Color grey2 = Color(0xff797979);
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color error = Color(0xffe61f34);
  static const Color black = Color(0xff000000);
  static const Color yellowBoder = Color(0xffCF9F02);
  static const Color yellowBg = Color(0xffFFF7D6);
  static const Color greenBg = Color(0xffDFFCF0);
  static const Color grayBg = Color(0xffF7F8F9);
  static const Color blueBg = Color(0xffE9F2FF);
  static const Color blueBorder = Color(0xff388BFF);

  static const Color dividerColor = Color(0xff626F86);
  static const Color blackFont = Color(0xff172B4D);
  static const Color dividerLineColor = Color(0xffDCDFE4);
  static const Color radioColor = Color(0xff8590A2);
  static const Color colorGreen = Color(0xff22A06B);
  static const Color colorDarkBlue = Color(0xff2C3E5D);
  static const Color colorOrangeLight = Color(0xffFFF5F0);
  static const Color colorPinkBf = Color(0xffFFEDEB);
  static const Color colorRed = Color(0xffF87462);

  static const Color colorWarningIcon = Color(0xff7F5F01);

  static const Color yellow = Color(0xffF5CD47);
  static const Color green = Color(0xff4BCE97);
  static const Color lightBlueBG = Color(0xffEBF3FF);
  static const Color textColorBlue = Color(0xff0858D0);
  static const Color lightOrangeBG = Color(0xffFFEDE7);
  static const Color OrangeBorder = Color(0xffFBD7C8);
  static const Color OrangeBackground = Color(0xffF8E6A0);
  static const Color disableGrayBG = Color(0xffF2F2F2);
  static const Color borderColorDisableGray = Color(0xffDCDFE4);
  static const Color yellowBG = Color(0xffFFE100);
  static const Color blueDarkBG = Color(0xff0C66E4);
  static const Color colorYellowLight = Color(0xffFFF4CD);
  static const Color colorYellowDark = Color(0xffBD9304);
  static const Color colorOrangeLights = Color(0xffFFBC9D);
  static const Color textColorBlueLight = Color(0xff0055CC);
  static const Color bgColorBlueLight = Color(0xffF6F9FF);
  static const Color debitColor = Color(0xffF12424);
  static const Color creditColor = Color(0xff339943);
  static const Color lightGrayColor = Color(0xffFAFAFA);

  static const Color socialBackground = Color(0xff828282);
  static const Color socialTextColor = Color(0xff191D23);
  static const Color pinkText = Color(0xffFB556E);
  static const Color orangePrimary = Color(0xffF16524);

  static const Color gradientStart = Color(0xff23a5c1);
  static const Color gradientMiddle = Color(0xff00456c);
  static const Color gradientEnd = Color(0xff23a5c1);

  List<Color> appGradient = [
    AppColors.orangePrimary.withOpacity(0.2),
    AppColors.orangePrimary.withOpacity(0),
    AppColors.orangePrimary.withOpacity(0),
    AppColors.orangePrimary.withOpacity(0),
    AppColors.orangePrimary.withOpacity(0),
    AppColors.orangePrimary.withOpacity(0),
  ];
}

extension HexColor on Color {
  static Color fromHex(String colorCode) {
    colorCode = colorCode.replaceAll("#", '');
    if (colorCode.length == 6) {
      colorCode = "FF$colorCode";
    }
    return Color(int.parse("0x$colorCode"));
  }

  static Color fromHexWithOpacity(String colorCode, {double opacity = 1.0}) {
    colorCode = colorCode.replaceAll("#", '');
    if (colorCode.length == 6) {
      colorCode = "FF$colorCode";
    }
    int colorValue = int.parse("0x$colorCode");
    return Color.fromRGBO(
      (colorValue >> 16) & 0xFF,
      (colorValue >> 8) & 0xFF,
      colorValue & 0xFF,
      opacity,
    );
  }
}

class ThemeNames {
  static final light = ThemeData.light().copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.colorWhite,
      cardColor: AppColors.colorWhite,
      shadowColor: AppColors.shadowColor,
      // buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      cardTheme: const CardTheme(
        surfaceTintColor: Colors.white,
      ),
      dialogTheme: const DialogTheme(
        surfaceTintColor: Colors.white,
      ),
      datePickerTheme: DatePickerThemeData(
          backgroundColor: AppColors.colorWhite,
          headerBackgroundColor: AppColors.orange,
          headerForegroundColor: AppColors.colorWhite,
          surfaceTintColor: AppColors.blackFontSubTitle,
          todayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.orange;
              }
              return AppColors.orange; // Return null for non-selected state
            },
          ),
          // dayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
          //       (Set<MaterialState> states) {
          //     if (states.contains(MaterialState.selected)) {
          //       return AppColors.orange;
          //     }
          //     return AppColors.orange; // Return null for non-selected state
          //   },
          // ),
          yearBackgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.orange;
              }
              return AppColors.colorWhite; // Return null for non-selected state
            },
          ),
          headerHelpStyle: Get.theme.textTheme.titleMedium?.copyWith(
            color: AppColors.colorGreen,
          )),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.orange; // Custom selected color
          }
          return AppColors.radioColor; // Custom unselected color
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.orange; // Custom selected color
          }
          return AppColors.colorWhite; // Custom unselected color
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        side: const BorderSide(color: AppColors.radioColor),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.blackFont,
        selectionColor: AppColors.blackFont,
        selectionHandleColor: AppColors.blackFont,
      ),
      snackBarTheme: SnackBarThemeData(contentTextStyle: getRegularStyle(fontColor: AppColors.colorWhite, fontSize: 14.sp), backgroundColor: AppColors.colorGreen),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: AppColors.colorLightBottomNavigationBar),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        textStyle: const TextStyle(color: AppColors.gradientMiddle, fontSize: 14, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),

        ),
      )),
      //Elevated Button Theme
      textTheme: TextTheme(
          displayLarge: getBoldStyle(fontColor: AppColors.blackFontTitle, fontSize: 24.sp),
          displayMedium: getMediumStyle(fontColor: AppColors.blackFontTitle, fontSize: 22.sp),
          displaySmall: getRegularStyle(fontColor: AppColors.blackFontSubTitle, fontSize: 16.sp),
          titleMedium: getSemiBoldStyle(fontColor: AppColors.orange, fontSize: 14.sp),
          bodySmall: getRegularStyle(fontColor: AppColors.blackFontTitle, fontSize: 14.sp),
          bodyLarge: getRegularStyle(fontColor: AppColors.grey)),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColors.orange, textStyle: getBoldStyle(fontColor: AppColors.orange, fontSize: 14.sp))),
      dividerColor: AppColors.disableButtonBackground,
      dividerTheme: const DividerThemeData(
        color: AppColors.disableButtonBackground,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: AppColors.colorWhite,
        backgroundColor: AppColors.colorWhite,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange,
              disabledBackgroundColor: AppColors.disableButtonBackground,
              disabledForegroundColor: AppColors.disableButtonText,
              foregroundColor: AppColors.colorWhite,
              textStyle: const TextStyle(color: AppColors.colorWhite, fontSize: 14, fontWeight: FontWeight.w600),
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              elevation: 5,
              shadowColor: Colors.transparent)),
      // Text Form Fields
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(8),
          hintStyle: getRegularStyle(fontColor: AppColors.hintText, fontSize: 14),
          labelStyle: getMediumStyle(fontColor: AppColors.darkGrey),
          errorStyle: getRegularStyle(fontColor: AppColors.textFieldErrorText),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.disableButtonBackground, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldBorder, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldBorder, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldErrorBorder, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldErrorBorder, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          )));

  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    // scaffoldBackgroundColor: AppColors.colorBlackBg,
    // cardColor: AppColors.colorBlackBg,
    // shadowColor: AppColors.shadowDarkColor,
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: AppColors.colordarkBottomNavigationBar),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ElevatedButton.styleFrom(
    //         backgroundColor: AppColors.colorButton,
    //         padding: const EdgeInsets.all(15),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(14),
    //         ),
    //         elevation: 5,
    //         shadowColor: Colors.transparent)),
  );
}

//100% - FF
// 95% - F2
// 90% - E6
// 85% - D9
// 80% - CC
// 75% - BF
// 70% - B3
// 65% - A6
// 60% - 99
// 55% - 8C
// 50% - 80
// 45% - 73
// 40% - 66
// 35% - 59
// 30% - 4D
// 25% - 40
// 20% - 33
// 15% - 26
// 10% - 1A
// 5% - 0D
// 0% - 00
