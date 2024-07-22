import '../../../network/base/base_api_response.dart';
import '../../entities/fill_form_request.dart';
import '../../entities/fill_form_response.dart';
import '../../entities/question_answer_response.dart';
import '../../entities/report_analysis_response.dart';
import '../../entities/upload_response.dart';

abstract class MainRepository {
  Future<FillFormResponse> fillReport(FillFormRequest loginRequestModel);

  Future<UploadResponse> uploadFile(String filepath);

  Future<ReportAnalysisResponse> reportAnalysis(String sessionId);

  Future<QuestionAnswerResponse> askQuestions(String sessionId, String query);
}
