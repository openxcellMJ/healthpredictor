import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';


import 'dio_provider.dart';
import 'error_handlers.dart';

class BaseRemoteSource {
  Dio get dioClient => DioProvider.dioWithHeaderToken;

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;
      if (response.statusCode != HttpStatus.ok || (response.data as Map<String, dynamic>)['statusCode'] != HttpStatus.ok) {}
      return response;
    } on DioException catch (dioError) {
      print("exception type is is==== ${dioError.error.runtimeType}");
      if(dioError.error.runtimeType.toString() == "SocketException")
        {
          DioException error = DioException(type: DioExceptionType.connectionError,requestOptions: RequestOptions(),message: "No Internet Available");
          Exception exception = handleDioError(error);
          throw exception;
        }
      else{
        Exception exception = handleDioError(dioError);
        print("exception is==== ${exception.runtimeType.toString()}");
        if (exception.runtimeType.toString() == "UnauthorizedException") {

        }
        throw exception;
      }

    }

    // catch (error) {
    //   if (error is BaseException) {
    //     rethrow;
    //   }
    //   throw handleError("$error");
    // }
  }
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
