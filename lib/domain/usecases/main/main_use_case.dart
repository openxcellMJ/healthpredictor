import 'package:envitely/domain/repositories/mains/main_repository.dart';

import '../../entities/fill_form_request.dart';
import '../../entities/fill_form_response.dart';

class MainUseCase {
  final MainRepository _repo;

  MainUseCase(this._repo);

  Future<FillFormResponse> fillReport(FillFormRequest loginRequestModel) {
    return _repo.fillReport(loginRequestModel);
  }
}
