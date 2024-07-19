import '../../../network/base/base_api_response.dart';
import '../../entities/fill_form_request.dart';
import '../../entities/fill_form_response.dart';



abstract class MainRepository {


  Future<FillFormResponse> fillReport(FillFormRequest loginRequestModel);
}
