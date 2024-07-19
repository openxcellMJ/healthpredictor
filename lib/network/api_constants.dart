import '../utils/utils.dart';

bool isMultiPart = false;

abstract class ApiConstants {
  //isLiveEnvironment True = Staging else Development
  static String baseUrl = "https://secondly-modern-osprey.ngrok-free.app";

  //api constant
  static const String contentType = "application/json";

  //authentication
  static String fillReport = "$baseUrl/health-record/";
}
