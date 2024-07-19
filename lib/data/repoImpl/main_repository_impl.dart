
import 'package:get/get.dart';

import '../../domain/entities/login/login_request.dart';
import '../../domain/entities/login/login_response.dart';

import '../../domain/repositories/mains/main_repository.dart';
import '../../network/base/base_api_response.dart';
import '../remote/network_data_source.dart';


class MainRepositoryImpl implements MainRepository {

  final NetworkDataSource _remoteSource = Get.find();

  @override
  Future<BaseApiResponse<LoginResponseModel>> logIn(LoginRequestModel loginRequestModel) {
    return _remoteSource.login(loginRequestModel);
  }

}
