import 'dart:io';

import 'package:envitely/domain/usecases/main/main_use_case.dart';
import 'package:envitely/values/strings_name.dart';
import 'package:file_picker/file_picker.dart';
import 'package:envitely/presentation/pages/main/form_answer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../custom_widgets/app_widgets.dart';
import '../../../domain/entities/ChatModels.dart';
import '../../../domain/entities/fill_form_request.dart';
import '../../../network/base/base_api_exception.dart';
import '../../../utils/utils.dart';
import '../../../values/app_colors.dart';
import '../../pages/main/form_answer_report_page.dart';

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

  final TextEditingController chatController = TextEditingController();

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

  var result = "".obs;
  var chats = [].obs;

  var isBotTyping = false.obs;
  var isListen = true.obs;
  var sessionId = "".obs;
  ScrollController scrollController = ScrollController();

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
        Get.to(FormAnswerReportPage(), arguments: response.predictions);
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
        sessionId.value = response.sessionId ?? "";
        callReportAnalysisData(sessionId.value);
        print("tetst=>success");
      }
    } catch (err) {
      AppWidgets.closeProgress();
      var msg = err as ApiException;
      Utils.showSnackBar(msg.message, color: AppColors.colorRed);
    }
  }

  callReportAnalysisData(String sessionId) async {
    AppWidgets.showProgress();
    try {
      var response = await mainUseCase.reportAnalysis(sessionId);
      AppWidgets.closeProgress();
      if (response != null) {
        Get.to(FormAnswerPage(), arguments: response.analysis);
      }
    } catch (err) {
      AppWidgets.closeProgress();
      var msg = err as ApiException;
      Utils.showSnackBar(msg.message, color: AppColors.colorRed);
    }
  }

  callQuestionAnswerData(String query) async {
    //AppWidgets.showProgress();
    try {
      var response = await mainUseCase.askQuestions(sessionId.value, query);
      //AppWidgets.closeProgress();
      if (response != null) {
        addBotMessage(response.answer ?? "");
      }
    } catch (err) {
      //AppWidgets.closeProgress();
      var msg = err as ApiException;
      Utils.showSnackBar(msg.message, color: AppColors.colorRed);
    }
  }

  void addBotMessage(String reply) {
    if (isListen == true) {
      chats.add(ChatModels(text: reply, owner: StringNames.BOT, dateTime: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())));
      chats.refresh();
      isBotTyping.value = false;
      changeStatus(false);
    }
  }

  void changeStatus(bool val) {
    isListen.value = val;
    _scrollToBottom();
  }

  _scrollToBottom() {
    if (scrollController.hasClients) scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      callUploadFileData(file.path);
    }
  }
}
