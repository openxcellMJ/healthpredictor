
import 'package:envitely/domain/repositories/mains/main_repository.dart';

import '../../../network/base/base_api_response.dart';
import '../../entities/login/login_request.dart';
import '../../entities/login/login_response.dart';


class MainUseCase {
  final MainRepository _repo;

  MainUseCase(this._repo);

  Future<BaseApiResponse<LoginResponseModel>> logIn(
      LoginRequestModel loginRequestModel) {
    return _repo.logIn(loginRequestModel);
  }


}
