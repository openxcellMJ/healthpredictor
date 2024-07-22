import 'dart:io';

import 'package:envitely/domain/usecases/main/main_use_case.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/app_widgets.dart';
import '../../../domain/entities/fill_form_request.dart';
import '../../../network/base/base_api_exception.dart';
import '../../../utils/utils.dart';
import '../../../values/app_colors.dart';

class HomeController extends GetxController {
  final MainUseCase mainUseCase;

  HomeController(this.mainUseCase);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController ageController = TextEditingController(text: "1");
  final TextEditingController heightController = TextEditingController(text: "1");
  final TextEditingController weightController = TextEditingController(text: "1");
  final TextEditingController sleepHoursController = TextEditingController(text: "1");
  final TextEditingController physicalExamController = TextEditingController();
  final TextEditingController waterIntakeController = TextEditingController(text: "1");
  final TextEditingController stepsCountController = TextEditingController(text: "1");
  final TextEditingController exerciseHoursController = TextEditingController(text: "1");
  final TextEditingController workHoursController = TextEditingController(text: "1");
  final TextEditingController systolicController = TextEditingController(text: "1");
  final TextEditingController diastolicController = TextEditingController(text: "1");
  final TextEditingController heartRateController = TextEditingController(text: "1");
  final TextEditingController bloodSugarController = TextEditingController(text: "1");
  var gender = 'Male'.obs;
  var medicalHistory = 'Hypertension'.obs;
  var heredityDiseases = 'Diabetes'.obs;
  var smokingStatus = 'Never'.obs;
  var alcoholConsumption = 'None'.obs;
  var physicalActivityLevel = 'Sedentary'.obs;
  var dietType = 'Omnivore'.obs;
  var stressLevel = 'Low'.obs;
  var currentMedications = 'Metformin'.obs;
  var frequencyOfCheckups = 'Annually'.obs;
  var physicalActivities = 'Running'.obs;

  var mySelectedAgendaDate = DateTime.now().obs;
  var activeCurrentStep = 0.obs;

  Future<void> selectDateForCreateAgenda(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            datePickerTheme: const DatePickerThemeData(
              headerBackgroundColor: AppColors.gradientMiddle,
              headerForegroundColor: Colors.white,
              backgroundColor: AppColors.colorWhite,
            ),
            colorScheme: const ColorScheme.dark(
              primary: AppColors.gradientMiddle,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
              background: AppColors.gradientMiddle,
            ),
            secondaryHeaderColor: AppColors.radioColor,
          ),
          child: child ?? Container(),
        );
      },
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != mySelectedAgendaDate.value) {
      mySelectedAgendaDate.value = picked;
      physicalExamController.text = Utils.getDOBFormatedDate(mySelectedAgendaDate.value.toString());
    }
  }

  fillFormApi(FillFormRequest loginRequestModel) async {
    print("tetst=>${loginRequestModel.toJson()}");
    AppWidgets.showProgress();
    try {
      var response = await mainUseCase.fillReport(loginRequestModel);
      AppWidgets.closeProgress();
      if (response != null) {
        print("tetst=>${response.predictions}");
      }
    } catch (err) {
      AppWidgets.closeProgress();
      var msg = err as ApiException;
      Utils.showSnackBar(msg.message, color: AppColors.colorRed);
    }
  }


  callUploadFileData(String filePath) async {
    AppWidgets.showProgress();
    try {
      var response = await mainUseCase.uploadFile(filePath);
      AppWidgets.closeProgress();
      if (response != null) {
        print("tetst=>success");
      }
    } catch (err) {
      AppWidgets.closeProgress();
      var msg = err as ApiException;
      Utils.showSnackBar(msg.message, color: AppColors.colorRed);
    }
  }
  void getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [ 'pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      print("tetst=>${file.path}");
      callUploadFileData(file.path);
      // callCertificateUpload(file.path, index, file);
    }
    // checkItemValidate(index);
  }
}
