import '../utils/utils.dart';

bool isMultiPart = false;

abstract class ApiConstants {

  //Customer : http://prod-vidola-lb-635463234.ap-southeast-1.elb.amazonaws.com:5000/customer
  // Titan : http://prod-vidola-lb-635463234.ap-southeast-1.elb.amazonaws.com:5000/titan
  // Common APIs : http://prod-vidola-lb-635463234.ap-southeast-1.elb.amazonaws.com:5000/common

  //isLiveEnvironment True = Staging else Development
  static String baseUrl = Utils.isLiveEnvironment ? "https://stgapi-vidola-be.vidolacorp.com/titan" :"https://vidola-web-api.apps.openxcell.dev/titan";
  static String commonBaseUrl = Utils.isLiveEnvironment ? "https://stgapi-vidola-be.vidolacorp.com/common":"https://vidola-web-api.apps.openxcell.dev/common";

  // isLiveEnvironment True = Production else Development
  // static String baseUrl = Utils.isLiveEnvironment ? "https://api-vidola-be.vidolacorp.com/titan" :"https://vidola-web-api.apps.openxcell.dev/titan";
  // static String commonBaseUrl = Utils.isLiveEnvironment ? "https://api-vidola-be.vidolacorp.com/common":"https://vidola-web-api.apps.openxcell.dev/common";


  //api constant
  static const String contentType = "application/json";

  //authentication
  static String login = "$baseUrl/auth/login";

}
