// import 'package:envitely/presentation/controller/main/home_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import '../../../custom_widgets/app_widgets.dart';
// import '../../../values/app_colors.dart';
// import '../../../values/app_images.dart';
// import 'question_answer_page.dart';
//
// class FormAnswerReportPage extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     if (Get.arguments != null) {
//       controller.result.value = Get.arguments;
//     }
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.colorWhite,
//         appBar: AppBar(
//           leading: IconButton(
//               color: Colors.black,
//               icon: SvgPicture.asset(AppImage.icArrowBack),
//               iconSize: 20.0,
//               onPressed: () {
//                 Get.back();
//               }),
//           automaticallyImplyLeading: true,
//           scrolledUnderElevation: 0,
//           elevation: 0.0,
//           centerTitle: true,
//           backgroundColor: Colors.transparent,
//           title: Text(
//             'Result',
//             style: Get.theme.textTheme.displayLarge?.copyWith(fontSize: 20, color: AppColors.gradientMiddle),
//           ),
//         ),
//         body: Obx(() => Markdown(data: controller.result.value,controller: controller.scrollController,styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
//             textTheme: TextTheme(
//                 bodyText2: TextStyle(
//                     fontSize: 20.0, color: Colors.black87))))) ),
//       ),
//     );
//   }
// }
