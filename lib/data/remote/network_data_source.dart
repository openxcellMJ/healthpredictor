import 'package:envitely/domain/entities/fill_form_response.dart';
import 'package:envitely/network/base_remote_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../domain/entities/fill_form_request.dart';

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
}
