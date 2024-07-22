import 'package:envitely/domain/entities/report_analysis_response.dart';
import 'package:get/get.dart';

import '../../domain/entities/fill_form_request.dart';
import '../../domain/entities/fill_form_response.dart';
import '../../domain/entities/question_answer_response.dart';
import '../../domain/entities/upload_response.dart';
import '../../domain/repositories/mains/main_repository.dart';
import '../remote/network_data_source.dart';

class MainRepositoryImpl implements MainRepository {
  final NetworkDataSource _remoteSource = Get.find();

  @override
  Future<FillFormResponse> fillReport(FillFormRequest loginRequestModel) {
    return _remoteSource.fillReport(loginRequestModel);
  }

  @override
  Future<UploadResponse> uploadFile(String filepath) {
    return _remoteSource.uploadFile(filepath);

  }

  @override
  Future<ReportAnalysisResponse> reportAnalysis(String sessionId) {
    return _remoteSource.reportAnalysis(sessionId);

  }


  @override
  Future<QuestionAnswerResponse> askQuestions(String sessionId,String query) {
    return _remoteSource.askQuestions(sessionId,query);

  }

}
