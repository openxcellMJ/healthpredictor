import 'package:get/get.dart';

import '../../domain/entities/fill_form_request.dart';
import '../../domain/entities/fill_form_response.dart';
import '../../domain/repositories/mains/main_repository.dart';
import '../remote/network_data_source.dart';

class MainRepositoryImpl implements MainRepository {
  final NetworkDataSource _remoteSource = Get.find();

  @override
  Future<FillFormResponse> fillReport(FillFormRequest loginRequestModel) {
    return _remoteSource.fillReport(loginRequestModel);
  }
}
