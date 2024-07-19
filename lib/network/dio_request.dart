
import 'package:dio/dio.dart';

import '../preferences/preference_utils.dart';
import 'dio_provider.dart';

class DioRequest {
  final dioClient = DioProvider.tokenClient;
  final RequestOptions requestOptions;


  DioRequest({required this.requestOptions});

  Future<Response<T>> retry<T>() async {
    var header = await getCustomHeaders();

    return await dioClient.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      options: Options(method: requestOptions.method,headers:header),
    );
  }

  Future<Map<String, String>> getCustomHeaders() async {
    final String accessToken = PreferenceUtils.getToken();
    print("test=>${accessToken}");
    var customHeaders = {'content-type': 'application/json'};
    customHeaders.addAll({
      'Authorization': "Bearer $accessToken",
      'language': PreferenceUtils.getAppLanguage(),
    });
    return customHeaders;
  }
}
