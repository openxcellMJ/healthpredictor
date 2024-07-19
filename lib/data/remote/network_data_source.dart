import 'dart:convert';
import 'dart:io';
import 'package:envitely/network/base_remote_source.dart';
import 'package:path/path.dart';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../domain/entities/login/login_request.dart';
import '../../domain/entities/login/login_response.dart';
import '../../network/api_constants.dart';
import '../../network/base/base_api_response.dart';

class NetworkDataSource extends BaseRemoteSource {
  Future<BaseApiResponse<LoginResponseModel>> login(
      LoginRequestModel queryParam) {
    isMultiPart = false;
    var dioCall = dioClient.post(ApiConstants.login, data: queryParam.toJson());
    try {
      return callApiWithErrorParser(dioCall).then((response) =>
          BaseApiResponse<LoginResponseModel>.fromJson(response.data,
              (response) => LoginResponseModel.fromJson(response)));
    } catch (e) {
      debugPrint(e.printError as String?);
      rethrow;
    }
  }
}
