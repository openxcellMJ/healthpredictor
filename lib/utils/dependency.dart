import 'package:get/get.dart';

import '../data/remote/network_data_source.dart';

import '../data/repoImpl/main_repository_impl.dart';
import '../domain/usecases/main/main_use_case.dart';
import '../presentation/controller/main/home_controller.dart';
import '../presentation/controller/splash/splash_controller.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut(() => NetworkDataSource(), fenix: true);

    Get.lazyPut(() => MainRepositoryImpl(), fenix: true);
    Get.lazyPut(() => MainUseCase(Get.find<MainRepositoryImpl>()), fenix: true);
    Get.put<HomeController>(HomeController(Get.find()), permanent: true);
    Get.lazyPut(() => SplashController(), fenix: true);
  }
}
