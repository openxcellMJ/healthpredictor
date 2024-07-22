import 'package:envitely/domain/repositories/mains/main_repository.dart';

import '../../entities/fill_form_request.dart';
import '../../entities/fill_form_response.dart';
import '../../entities/report_analysis_response.dart';
import '../../entities/upload_response.dart';

class MainUseCase {
  final MainRepository _repo;

  MainUseCase(this._repo);

  Future<FillFormResponse> fillReport(FillFormRequest loginRequestModel) {
    return _repo.fillReport(loginRequestModel);
  }

  Future<UploadResponse> uploadFile(String filepath) {
    return _repo.uploadFile(filepath);
  }

  Future<ReportAnalysisResponse> reportAnalysis(String sessionId) {
    return _repo.reportAnalysis(sessionId);
  }
}
