import '../../../network/base/base_api_response.dart';
import '../../entities/login/login_request.dart';
import '../../entities/login/login_response.dart';


abstract class MainRepository {
  Future<BaseApiResponse<LoginResponseModel>> logIn(LoginRequestModel loginRequestModel);

}
