import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'base/base_api_exception.dart';
import 'pretty_dio_logger.dart';

Exception handleDioError(DioException dioError) {
  switch (dioError.type) {
    case DioExceptionType.cancel:
    // return AppException(message: "Request to API server was cancelled");
    case DioExceptionType.connectionTimeout:
    // return AppException(message: "Connection timeout with API server");
    case DioExceptionType.connectionError:
      return NetworkApiException("No internet connection", false);
    case DioExceptionType.receiveTimeout:
      return TimeoutException("Receive timeout in connection with API server");
    case DioExceptionType.sendTimeout:
      return TimeoutException("Send timeout in connection with API server");
    case DioExceptionType.badResponse:
      return _parseDioErrorResponse(dioError);
    default:
      return _parseDioErrorResponse(dioError);
  }
}

Exception _parseDioErrorResponse(DioException dioError) {
  final logger = PrettyDioLogger();
  dynamic statusCode = dioError.response?.statusCode ?? -1;
  dynamic status = false;
  dynamic serverMessage;
  dynamic key;
  try {
    if (statusCode == -1 ||
        statusCode == HttpStatus.ok ||
        statusCode == HttpStatus.created) {
      statusCode = dioError.response?.data != null
          ? dioError.response?.data["statusCode"]
          : -1;
    }
    status = dioError.response?.data != null
        ? dioError.response?.data["status"]
        : " ";
    serverMessage = dioError.response?.data != null
        ? dioError.response?.data["message"]
        : " ";
    key =
        dioError.response?.data != null ? dioError.response?.data["key"] : " ";

    logger.logPrint("${serverMessage}");
    logger.logPrint(key);

  } catch (e, s) {
    logger.logPrint("$e");
    logger.logPrint(s.toString());

    serverMessage = "Something went wrong. Please try again later.";
  }

  switch (statusCode) {
    // case 400:
    //   return 'Bad request.';
    // case 401:
    //   return 'Authentication failed.';
    // case 403:
    //   return 'The authenticated user is not allowed to access the specified API endpoint.';
    // case 404:
    //   return 'The requested resource does not exist.';
    // case 405:
    //   return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
    // case 415:
    //   return 'Unsupported media type. The requested content type or version number is invalid.';
    // case 422:
    //   return 'Data validation failed.';
    // case 429:
    //   return 'Too many requests.';
    // case 500:
    //   return 'Internal server error.';
    // default:
    //   return 'Oops something went wrong!';
    //
    case HttpStatus.serviceUnavailable:
      return ServiceUnavailableExceptionAPI("Service Temporarily Unavailable");
    case HttpStatus.notFound:
      return NotFoundException(serverMessage ?? "", status, key ?? "");
    case 401:
      return UnauthorizedException("unauthorized", key ?? "");
    // case 401:
    //   return UnauthorizedException(serverMessage ?? "Unauthorized", key ?? "");
    default:
      return ApiException(
          httpCode: statusCode,
          status: status,
          message: serverMessage ?? "",
          key: key ?? "");
  }
}
