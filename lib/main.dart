import 'package:envitely/translation%20/translation.dart';
import 'package:envitely/utils/approutes.dart';
import 'package:envitely/utils/dependency.dart';
import 'package:envitely/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initialize();
  runApp(const MyApp());
}

_initialize() async {
  DependencyCreator.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,

      builder: (context, child) {
        return GetMaterialApp(

          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          translationsKeys: AppTranslation.translationsKeys,
          // locale: Get.deviceLocale,
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          title: "HealthPredictor Plus",
          getPages: appRoutes(),
          initialRoute: RoutesName.mainView,
          theme: ThemeNames.light,
          darkTheme: ThemeNames.light,
          themeMode: ThemeMode.light,
          //builder: (context, child) => const SplashPage(),
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
