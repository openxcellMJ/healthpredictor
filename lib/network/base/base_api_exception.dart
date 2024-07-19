import 'dart:io';

abstract class BaseApiException implements Exception {
  final int httpCode;
  final bool status;
  final String message;
  final String key;

  BaseApiException(
      {this.httpCode = -1,
      this.status = false,
      this.message = "",
      this.key = ""});
}

class ServiceUnavailableException extends BaseApiException {
  ServiceUnavailableException(String message)
      : super(
            httpCode: HttpStatus.serviceUnavailable,
            message: message,
            status: false);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message, String key)
      : super(
            httpCode: HttpStatus.unauthorized,
            message: message,
            status: false,
            key: key);
}
class CustomUnauthorizedException extends ApiException {
  CustomUnauthorizedException(String message)
      : super(
      httpCode: HttpStatus.unauthorized,
      message: message,
      status: false,
    statusdescription: "unauthorized");
}
class ApiException extends BaseApiException {
  ApiException({
    required int httpCode,
    required bool status,
    String statusdescription = "",
    String message = "",
    String key = "",
  }) : super(httpCode: httpCode, status: status, message: message, key: key);
}

class ServiceUnavailableExceptionAPI extends ApiException {
  ServiceUnavailableExceptionAPI(String message)
      : super(
            httpCode: HttpStatus.serviceUnavailable,
            message: message,
            status: false);
}

class NotFoundException extends ApiException {
  NotFoundException(String message, bool status, String key)
      : super(
            httpCode: HttpStatus.notFound,
            status: status,
            message: message,
            key: key);
}

class NetworkApiException extends ApiException {
  NetworkApiException(String message, bool status)
      : super(
            httpCode: HttpStatus.badGateway, status: status, message: message);
}

class NetworkApiExceptionBase extends BaseApiException {
  NetworkApiExceptionBase(String message, bool status)
      : super(
      httpCode: HttpStatus.badGateway, status: status, message: message);
}
