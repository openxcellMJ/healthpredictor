import 'dart:io';

import 'package:envitely/custom_widgets/app_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../values/app_colors.dart';

//This is utility class
extension E on String {
  String lastChars(int n) => substring(length - n);
}

class FormValidator {
  static bool validateEmail(String? email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (email!.trim().isEmpty) {
      return false;
    } else if (!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool validateEmailSignup(String? email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (email!.isNotEmpty && !regExp.hasMatch(email)) {
      return false;
    }
    // else if (!regExp.hasMatch(email)) {
    //   return false;
    // }
    return true;
  }

  static bool validatePassword(String? value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    if (value!.trim().isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static bool validateMobileNumber(String? value) {
    String pattern = r'^(?!.*-.*-.*-)(?=(?:\d{5,12}$)|(?:(?=.{6,13}$)[^-]*-[^-]*$)|(?:(?=.{7,14}$)[^-]*-[^-]*-[^-]*$)  )[\d-]+$';
    RegExp regExp = RegExp(pattern);
    if (value!.trim().isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static String validateCPassword(String? value) {
    // if (value!.isEmpty) return strings_name.str_emplty_cpassword;
    // if (value.length < 6) return strings_name.str_cpassword_length;
    return "";
  }

  static String validatePhone(String? value) {
    // if (value!.isEmpty) return strings_name.str_emplty_phone;
    // if (value.length < 10) return strings_name.str_emplty_phone;
    return "";
  }
}

class Utils {
  // static FirebaseMessage firebaseMessage = FirebaseMessage();
  // static NotificationPopupData firebaseMessagePopup = NotificationPopupData();
  //
  static bool isLiveEnvironment = false;
  static bool isFromHideKeyboard = false;
  static bool isUpdatePopupShown = false;
  static bool isProgressShown = false;
  static bool isFromNotificationClick = false;
  static dynamic redirectJobTabIndex = -1;
  static dynamic subIndexRedirect = -1;

  static String value = "";

  static String capitalize(String value) {
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }

  static bool isValidFileSize(File file, [int allowedFileSize = 20]) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (kDebugMode) {
      print("File Size is $sizeInMb");
    }
    if (sizeInMb > allowedFileSize) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static bool checkTodayOrNot(int timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final aDate = DateTime(dateTime1.year, dateTime1.month, dateTime1.day);
    return aDate == today;
  }

  static String getHoursDifferenceTimeOnline(int timestamp) {
    print("My Timestamp is ${timestamp}");
    //print("My Timestamp is ${Utils.parseTimeStampWithFormat(timestamp, "hh:mm dd:MM:yyyy")}");
    int d1 = DateTime.now().millisecondsSinceEpoch;
    var diff = d1 - timestamp;
    print(d1 - timestamp);
    var pTime = Duration(milliseconds: diff);
    print("Hours ==== ${pTime.inHours}");
    print("Hours ==== ${pTime.inDays}");
    return pTime.inHours > 24 ? "${pTime.inDays.toString()} days" : "${pTime.inHours.toString()} hrs";
  }

  static String fileConvert(String fileSizeInBytes) {
    // int sizeInBytes = file.lengthSync();
    double sizeInMb = (double.parse(fileSizeInBytes)) / (1024 * 1024);
    // double fileSizeInKB =  (double.parse(fileSizeInBytes) / 1024) / 1024;
    // double fileSizeInMB =  (fileSizeInKB / 1024) / 1024;
    return sizeInMb.toStringAsFixed(2);
  }

  static Future<bool> askForPermission(Permission permission) async {
    print("inside askFor Permission");
    PermissionStatus status = await permission.request();
    print("Permission Status1 $status permission Name ${permission.toString()}");
    bool isGranted = false;
    if (status.isGranted) {
      //  permissions granted
      isGranted = true;
    } else if (status.isDenied) {
      PermissionStatus status = await permission.request();
      print("Permission Status2 $status permission Name ${permission.toString()}");
    } else if (status.isPermanentlyDenied) {
      //  permissions permanently denied, open app settings
      if (Platform.isIOS) {
        showPermissionDialog(permission);
      } else {
        await openAppSettings();
      }
    }
    return isGranted;
  }

  static Future<bool> askForPermissionNew(Permission permission) async {
    PermissionStatus status = await permission.request();
    print("My Permission Status is ${status} permission ${permission.toString()}");
    bool isGranted = false;
    if (status.isGranted) {
      //  permissions granted
      isGranted = true;
    } else {
      //  permissions permanently denied, open app settings
      // await openAppSettings();
      showPermissionDialog(permission);
    }
    return isGranted;
  }

  static showPermissionDialog(Permission permission) {
    Get.dialog(AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: AppWidgets.setTextWidget('strAllowPermission'.tr,
                lines: 3, styles: Get.theme.textTheme.displayMedium?.copyWith(color: AppColors.blackFontTitle, fontSize: 20)),
          ),
          const SizedBox(height: 12),
          Center(
            child: AppWidgets.setTextWidget(getPermissionTextBasedOnPermission(permission),
                lines: 6, align: TextAlign.center, styles: Get.theme.textTheme.displaySmall?.copyWith(color: AppColors.blackFontTitle, fontSize: 16)),
          ),
          const SizedBox(height: 24),
          AppWidgets.setElevatedButton('strSettings'.tr, () async {
            Get.back();
            await openAppSettings();
          }),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child:
                AppWidgets.setTextWidget('strCancel'.tr, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.orange, fontSize: 14)),
          ),
          const SizedBox(height: 10)
        ],
      ),
      alignment: Alignment.center,
    ));
  }

  static getPermissionTextBasedOnPermission(Permission permission) {
    if (permission == Permission.microphone) {
      return 'strAudioPermissionDescSetting'.tr;
    } else if (permission == Permission.camera) {
      return 'strCameraPermissionDescSetting'.tr;
    } else if (permission == Permission.photos) {
      return 'strPhotoPermissionDescSetting'.tr;
    } else if (permission == Permission.location) {
      return 'strLocationPermissionDescSetting'.tr;
    } else if (permission == Permission.notification) {
      return 'strNotificationPermissionDescSetting'.tr;
    }
  }

  static Future<PermissionStatus> askForLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status;
  }

  static String formatDateTime(String dateTimeString, String formate) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat formatter = DateFormat(formate);
    return formatter.format(dateTime);
  }

  static String getJobsFormatedDate(String date, String myOutputFormat) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    var outputFormat = DateFormat(myOutputFormat);
    var outputDate = outputFormat.format(inputDate);
    print("Output Date is ${outputDate}");
    return outputDate.toString();
  }

  static String covertTimeToDate(dynamic dateTimeString, String formate) {
    if (dateTimeString != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateTimeString);
      String formattedDateTime = DateFormat(formate).format(dateTime);
      return formattedDateTime;
    }
    return "";
  }

  static int calculateDayDifference(int timestamp1, int timestamp2) {
    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(timestamp1);
    DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(timestamp2);
    int differenceInDays = dateTime2.difference(dateTime1).inDays;
    return differenceInDays;
  }

  static int calculateHoursDifference(int timestamp1, int timestamp2) {
    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(timestamp1);
    DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(timestamp2);
    int differenceInDays = dateTime2.difference(dateTime1).inHours;
    return differenceInDays;
  }

  static int calculateSecondDifference(int timestamp1, int timestamp2) {
    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(timestamp1);
    DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(timestamp2);
    int differenceInDays = dateTime2.difference(dateTime1).inSeconds;
    return differenceInDays;
  }

  static int calculateYearDifference(int timestamp1, int timestamp2) {
    var days = calculateDayDifference(timestamp1, timestamp2);
    int differenceInYear = (days / 365).toInt();
    return differenceInYear;
  }

  static String getServerFormatedDate(String date, String myOutputFormat) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    var outputFormat = DateFormat(myOutputFormat);
    var outputDate = outputFormat.format(inputDate);
    print("Output Date is ${outputDate}");
    return outputDate.toString();
  }

  // static Future<String> getBuildNumber() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String version = packageInfo.version;
  //   String code = packageInfo.buildNumber;
  //   return version;
  // }

  static String timeAgoSinceDate(int dateString, {bool numericDates = true}) {
    DateTime mDate = DateTime.fromMillisecondsSinceEpoch(dateString);
//    DateTime mDate = DateFormat("dd-MM-yyyy h:mma").parse(dateString);
    final date2 = DateTime.now();
    Duration difference;
    if (date2.compareTo(mDate) > 0) {
      difference = date2.difference(mDate);
      if ((difference.inDays / 365).floor() >= 2) {
        return "strTimeyearsago".trParams({
          'time': "${(difference.inDays / 365).floor()}" ?? "",
        });
      } else if ((difference.inDays / 365).floor() >= 1) {
        return (numericDates) ? 'str1yearago'.tr : 'strLastyear'.tr;
      } else if ((difference.inDays / 30).floor() >= 2) {
        return "strTimemonthsago".trParams({
          'time': "${(difference.inDays / 30).floor()}" ?? "",
        });
      } else if ((difference.inDays / 30).floor() >= 1) {
        return (numericDates) ? 'str1monthago'.tr : 'strLastmonth'.tr;
      } else if ((difference.inDays / 7).floor() >= 2) {
        return "strTimeweeksago".trParams({
          'time': "${(difference.inDays / 7).floor()}" ?? "",
        });
      } else if ((difference.inDays / 7).floor() >= 1) {
        return (numericDates) ? 'str1weekago'.tr : 'strLastago'.tr;
      } else if (difference.inDays >= 2) {
        return "strTimedaysago".trParams({
          'time': "${(difference.inDays).floor()}" ?? "",
        });
      } else if (difference.inDays >= 1) {
        return (numericDates) ? 'str1dayago'.tr : 'strYesterday'.tr;
      } else if (difference.inHours >= 2) {
        return "strTimehoursago".trParams({
          'time': "${(difference.inHours).floor()}" ?? "",
        });
      } else if (difference.inHours >= 1) {
        return (numericDates) ? 'str1hourago'.tr : 'strAnhourago'.tr;
      } else if (difference.inMinutes >= 2) {
        return "strTimeminutesago".trParams({
          'time': "${(difference.inMinutes).floor()}" ?? "",
        });
      } else if (difference.inMinutes >= 1) {
        return (numericDates) ? 'str1minuteago'.tr : 'strAminuteago'.tr;
      } else if (difference.inSeconds >= 3) {
        return "strTimesecondsago".trParams({
          'time': "${(difference.inSeconds).floor()}" ?? "",
        });      } else {
        return 'strJustnow'.tr;
      }
    } else {
      difference = mDate.difference(date2);

      if ((difference.inDays / 365).floor() >= 2) {
        return '${(difference.inDays / 365).floor()} years left';
      } else if ((difference.inDays / 365).floor() >= 1) {
        return (numericDates) ? '1 year left' : 'An year left';
      } else if ((difference.inDays / 30).floor() >= 2) {
        return '${(difference.inDays / 365).floor()} months left';
      } else if ((difference.inDays / 30).floor() >= 1) {
        return (numericDates) ? '1 month left' : 'An month left';
      } else if ((difference.inDays / 7).floor() >= 2) {
        return '${(difference.inDays / 7).floor()} weeks left';
      } else if ((difference.inDays / 7).floor() >= 1) {
        return (numericDates) ? '1 week left' : 'An week left';
      } else if (difference.inDays >= 2) {
        return '${difference.inDays} days left';
      } else if (difference.inDays >= 1) {
        return (numericDates) ? '1 day left' : 'Yesterday';
      } else if (difference.inHours >= 2) {
        return '${difference.inHours} hours left';
      } else if (difference.inHours >= 1) {
        return (numericDates) ? '1 hour left' : 'An hour left';
      } else if (difference.inMinutes >= 2) {
        return '${difference.inMinutes} minutes left';
      } else if (difference.inMinutes >= 1) {
        return (numericDates) ? '1 minute left' : 'A minute left';
      } else if (difference.inSeconds >= 3) {
        return '${difference.inSeconds} seconds left';
      } else {
        return 'Just now';
      }
    }
  }

  static String parseTimeStamp(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    var d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(date);
    return d12;
  }

  static String parseTimeStampWithFormat(int value, String format) {
    var date = DateTime.fromMillisecondsSinceEpoch(value);
    var d12 = DateFormat(format).format(date);
    return d12;
  }

  static String getMinuteDifferenceOnline(int timestamp) {
    print("My Timestamp is ${timestamp}");
    //print("My Timestamp is ${Utils.parseTimeStampWithFormat(timestamp, "hh:mm dd:MM:yyyy")}");
    int d1 = DateTime.now().millisecondsSinceEpoch;
    print("My Current Timestamp is ${d1}");
    final d2 = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = d1 - timestamp;
    print(d1 - timestamp);
    var pTime = Duration(milliseconds: diff);
    return pTime.inMinutes.toString();
  }

  static printLogs(dynamic message) {
    if (kDebugMode) {
      print("Exception=>$message");
    }
  }

  // static void showSnackBar(String message, {Color? color,int second = 3}) {
  //   // Get.showSnackbar(
  //   //   GetSnackBar(
  //   //     message: message,
  //   //     isDismissible: true,
  //   //     backgroundColor: color,
  //   //     duration: const Duration(seconds: 3),
  //   //   ),
  //   // );
  //   if(color == AppColors.error)
  //   {
  //     second = 5;
  //   }
  //   Get.showSnackbar(
  //     GetSnackBar(
  //       messageText: AppWidgets.setTextWidget(message, styles: Get.theme.snackBarTheme.contentTextStyle, lines: 5),
  //       message: message,
  //       margin: const EdgeInsets.all(10),
  //       padding: const EdgeInsets.all(20),
  //       isDismissible: true,
  //       borderRadius: 8,
  //       backgroundColor: color ?? Get.theme.snackBarTheme.backgroundColor!,
  //       duration:  Duration(seconds: second),
  //     ),
  //   );
  // }

  // static void showSnackBarWithContext(String message, {Color? color, int second = 2}) {
  //   if(color == AppColors.error)
  //   {
  //     second = 5;
  //   }
  //   var snackBar = SnackBar(
  //     content: AppWidgets.setTextWidget(message, styles: Get.theme.snackBarTheme.contentTextStyle, lines: 5),
  //     backgroundColor: color ?? Get.theme.snackBarTheme.backgroundColor,
  //     duration: Duration(seconds: second),
  //     margin: const EdgeInsets.all(10),
  //     padding: const EdgeInsets.all(20),
  //     behavior: SnackBarBehavior.floating,
  //
  //   );
  //   if (Get.context != null) {
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  //   }
  // }

  // static void getDialog({String? title, String? content, String? positiveButtonText, String? negativeButtonText, required Function positiveButtonClick, required Function negativeButtonClick}) {
  //   Get.dialog(AlertDialog(
  //     contentPadding: const EdgeInsets.all(10),
  //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
  //     title: Text(title ?? "title", style: textStyle16),
  //     content: Container(margin: const EdgeInsets.only(left: 12), child: Text(content ?? "content", style: textStyleBlack114)),
  //     actionsAlignment: MainAxisAlignment.spaceEvenly,
  //     actions: [
  //       SizedBox(
  //         width: 120,
  //         height: 45,
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //               backgroundColor: AppColors.colorButton,
  //               padding: const EdgeInsets.all(2),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               elevation: 5,
  //               shadowColor: Colors.transparent),
  //           child: Text(
  //             positiveButtonText ?? "Yes",
  //             style: textStyleWhiteBold18,
  //           ),
  //           onPressed: () {
  //             Get.back();
  //             positiveButtonClick();
  //           },
  //         ),
  //       ),
  //       SizedBox(
  //         width: 120,
  //         height: 45,
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //               backgroundColor: AppColors.colorLightBlack,
  //               padding: const EdgeInsets.all(2),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               elevation: 5,
  //               shadowColor: Colors.transparent),
  //           child: Text(
  //             'strNo'.tr,
  //             style: textStyleWhiteBold18,
  //           ),
  //           onPressed: () {
  //             Get.back();
  //             negativeButtonClick();
  //           },
  //         ),
  //       ),
  //     ],
  //   ));
  // }

  // static void showSnackBarWithContext(String message, Color color, BuildContext context) {
  //   var snackBar = SnackBar(
  //     content: Text(
  //       message,
  //       style: textStyle13White,
  //     ),
  //     backgroundColor: color,
  //     duration: const Duration(seconds: 2),
  //   );
  //
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }


  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // static Widget nodataFound() {
  //   return Center(
  //       child: Lottie.asset(
  //     AppImage.ic_no_data,
  //     height: 220.h,
  //     width: 220.w,
  //   ));
  // }

  // static void showProgress() {
  //   Future.delayed(Duration.zero, () async {
  //     Get.dialog(Center(
  //       child: OverflowBox(
  //           minHeight: 110,
  //           maxHeight: 110,
  //           child: Stack(
  //             children: [
  //               Lottie.asset(AppImage.icLoader),
  //               Positioned.fill(
  //                   child: Align(
  //                       alignment: Alignment.center,
  //                       child: Image.asset(
  //                         AppImage.icLogoRound,
  //                         width: 45,
  //                         height: 45,
  //                       ))),
  //             ],
  //           )),
  //     ));
  //   });
  //
  // }

  static void removeFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void hidard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String getDOBFormatedDate(String date) {
    var inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  static void screenNavigation<T>(Widget page, {T? arguments}) {
    Get.to(() => page, arguments: arguments);
  }

  static void screenNavigationByNamed<T>(
    String routeName, {
    T? arguments,
    bool preventDuplicates = true,
  }) {
    printRouteName(routeName);
    Get.toNamed(
      routeName,
      arguments: arguments,
      preventDuplicates: preventDuplicates,
    );
  }

  static Future<T?>? screenNavigationByNamedWithReturnType<T>(String routeName, {T? arguments}) {
    printRouteName(routeName);
    return Get.toNamed(routeName, arguments: arguments);
  }

  static void screenNavigationOffAllByNamed<T>(String routeName, {T? arguments}) {
    printRouteName(routeName);
    Get.offAllNamed(routeName, arguments: arguments);
  }

  static void removeMiddleScreens<T>(String routeNames, {T? arguments}) {
    printRouteName(routeNames);
    Get.offNamedUntil(routeNames, (Route<dynamic> route) => route.isFirst, arguments: arguments);
  }

  static void printRouteName(String routeName) {
    print("Current Route is === $routeName");
  }

  // static showPermissionDialog(String middleText, Future<PermissionStatus> status) {
  //   Get.defaultDialog(
  //     title: 'strPermissionRequire'.tr,
  //     middleText: middleText,
  //     backgroundColor: Colors.white,
  //     titleStyle: textStyleRed16,
  //     middleTextStyle: textStyle14,
  //     barrierDismissible: false,
  //     cancel: SizedBox(
  //       width: 100,
  //       child: CustomButtonWithoutBg(
  //           text: 'strCancel'.tr,
  //           buttonPadding: 5,
  //           fontSize: 12,
  //           click: () {
  //             Get.back();
  //           }),
  //     ),
  //     confirm: SizedBox(
  //       width: 100,
  //       child: CustomButton(
  //           text: 'strAllow'.tr,
  //           buttonPadding: 5,
  //           fontSize: 12,
  //           click: () async {
  //             Get.back();
  //             await openAppSettings().then(
  //               (value) async {
  //                 if (value) {
  //                   if (await status.isPermanentlyDenied == true && await status.isGranted == false) {
  //                     openAppSettings();
  //                     // permissionServiceCall(); /* opens app settings until permission is granted */
  //                   }
  //                 }
  //               },
  //             );
  //           }),
  //     ),
  //     radius: 10,
  //   );
  // }

  // static shareLink(String link) {
  //   String text = 'Check out my awesome app: $link';
  //   Share.share(text);
  // }
}

class DateFormate {
  // static String toFormate(int timeStamp,
  //     {String formate = "dd MMMM yyyy hh:mm a"}) {
  //   final f = new DateFormat(formate);
  //   return f.format(new DateTime.fromMillisecondsSinceEpoch(timeStamp ?? 0));
  // }

  static String formatHHMMSS(int seconds) {
    if (seconds != null && seconds != 0) {
      int hours = (seconds / 3600).truncate();
      seconds = (seconds % 3600).truncate();
      int minutes = (seconds / 60).truncate();

      String hoursStr = (hours).toString().padLeft(2, '0');
      String minutesStr = (minutes).toString().padLeft(2, '0');
      String secondsStr = (seconds % 60).toString().padLeft(2, '0');

      if (hours == 0) {
        return "$minutesStr:$secondsStr";
      }
      return "$hoursStr:$minutesStr:$secondsStr";
    } else {
      return "";
    }
  }
// static String toFormate1(int timeStamp,
//     {String formate = "dd  / MM  / yyyy  hh:mm a"}) {
//   final f = new DateFormat(formate);
//   return f.format(new DateTime.fromMillisecondsSinceEpoch(timeStamp ?? 0));
// }

// static String toFormate2(int timeStamp,
//     {String formate = "dd  / MM  / yyyy  hh:mm a"}) {
//   final f = new DateFormat(formate);
//   return f.format(new DateTime.fromMillisecondsSinceEpoch(timeStamp ?? 0));
// }

// DateTime convertTimeStampToDateTime(int timeStamp) {
//   var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
//   return dateToTimeStamp;
// }

// String convertTimeStampToHumanDate(int timeStamp) {
//   var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
//   return DateFormat('dd MMMM yyyy hh:mm a').format(dateToTimeStamp);
// }

// String convertTimeStampToHumanHour(int timeStamp) {
//   var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
//   return DateFormat('HH:mm').format(dateToTimeStamp);
// }
}



enum VerificationType { EMAIL_VERIFY, PHONE_VERIFY, DEVICE_VERIFY, FORGOT_PASSWORD_TITAN, CHANGE, WITHDRAWAL, ADD_BANK }

enum InputType {
  EMAIL,
  PHONE_NUMBER,
}

enum JobResponseStatus { ACCEPTED, DECLINED, NO_RESPONSE, BIDS_PLACED }

enum InboxSubTypes { INFO, PROMOTION, DANGER }

enum UpdateTypes { FORCE_UPDATE, SOFT_UPDATE }

enum ErrorKey { email, phoneNumber, password, code, accountHolderName, accountNumber, bicCode }

enum VerificationStatus { NOT_APPLIED, PENDING, ACCEPTED, DECLINED, SUSPENDED_TEMPORARY, SUSPENDED }

enum AppealStatus { PENDING, ACCEPTED, DECLINED }

enum MainJobTypes { TROUBLESHOOT }

enum MainOrderType { NEW, REWORK }

enum MainOrderStatus { POSTED, SCHEDULED }

enum JobTypes { POSTED, SCHEDULED, ONGOING, FINISHED, RESCHEDULED, CANCELLED }

enum AdditionalChargeStatus { PENDING, DECLINED, ACCEPTED }

enum InboxTypes { EARNINGS, JOBS, REQUESTS, INFO_AND_PROMO, ORDERS }

enum WithdrawStatus { PENDING, SUCCESS, FAILED }

enum PaymentType {
  JOB_PAYMENT,
  COMPENSATION_FEE,
  PENALTY_FEE,
  WITHDRAWAL,
  DEBIT,
  CREDIT,
  REFERRAL_REWARD,
  ORDER_COMPLETE_REWARD,
}

enum AcceptDecline { ACCEPT, DECLINE }

enum AssessmentStatus { PENDING, SCHEDULED, DECLINE, PASSED }

enum AssessmentTestStatus { ACCEPTED, DECLINE, PENDING }

enum ProgressStatus {
  SCHEDULED,
  ONGOING,
  CANCELLED,
  REQUESTED_BY_CUSTOMER,
  CANCELLED_BY_CUSTOMER,
  CANCELLED_BY_TITAN,
  REQUESTED_BY_TITAN,
  RESCHEDULED,
  COMPLETED,
  COMPLETED_BY_TITAN,
}

// enum EarningTypes { PENDING, ORDERS, WALLET }

enum EarningTypes { ORDERS, WALLET }

enum DeviceTypes { ANDROID, IOS }
