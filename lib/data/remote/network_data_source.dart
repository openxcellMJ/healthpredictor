import 'package:envitely/domain/entities/fill_form_response.dart';
import 'package:envitely/network/base_remote_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../domain/entities/fill_form_request.dart';

import '../../domain/entities/upload_response.dart';
import '../../network/api_constants.dart';
import '../../network/base/base_api_response.dart';

class NetworkDataSource extends BaseRemoteSource {


  Future<FillFormResponse> fillReport(FillFormRequest createNoteRequestModel) {
    isMultiPart = false;
    var dioCall = dioClient.post(ApiConstants.fillReport, data: createNoteRequestModel.toJson());
    try {
      return callApiWithErrorParser(dioCall).then((response) => FillFormResponse.fromJson(response.data));
    } catch (e) {
      debugPrint(e.printError as String?);
      rethrow;
    }
  }
  Future<UploadResponse> uploadFile(String filepath) async {
    isMultiPart = true;

    final mimeTypeData = lookupMimeType(filepath)?.split('/');
    String? fileName = filepath.split('/').last;

    dio.FormData? data = null;

    data = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(
        filepath ?? "",
        filename: fileName,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
      ),
    });

    var dioCall = dioClient.post(ApiConstants.uploadReport, data: data);
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        isMultiPart = false;
        return UploadResponse.fromJson(response.data);
      });

    } catch (e) {
      isMultiPart = false;
      debugPrint(e.printError as String?);
      rethrow;
    }
  }

}
