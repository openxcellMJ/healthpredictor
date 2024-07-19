import 'package:dio/dio.dart';


import 'api_constants.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    var customHeaders = {'content-type': (isMultiPart) ? 'multipart/form-data' : 'application/json'};
   // final String accessToken = PreferenceUtils.getToken();
    // customHeaders.addAll({
    //   'Authorization': "Bearer $accessToken",
    //   'language': PreferenceUtils.getAppLanguage(),
    // });

    return customHeaders;
  }
}
