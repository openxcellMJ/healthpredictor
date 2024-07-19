import 'package:envitely/presentation/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../main.dart';

appRoutes() => [
      GetPage(
        name: RoutesName.mainView,
        page: () => const SplashPage(),
      ),
    ];

abstract class RoutesName {
  static const String mainView = "/mainView";
}
