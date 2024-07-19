import 'dart:io';

import 'package:envitely/domain/usecases/main/main_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as MyPermissionStatus;
import '../../../data/remote/network_data_source.dart';
import '../../../main.dart';
import '../../../preferences/preference_utils.dart';
import '../../../utils/utils.dart';
import '../../../values/app_colors.dart';

class HomeController extends GetxController {
  final MainUseCase mainUseCase;

  HomeController(this.mainUseCase);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sleepHoursController = TextEditingController();
  final TextEditingController physicalExamController = TextEditingController();
  final TextEditingController waterIntakeController = TextEditingController();
  final TextEditingController stepsCountController = TextEditingController();
  final TextEditingController exerciseHoursController = TextEditingController();
  final TextEditingController workHoursController = TextEditingController();
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController bloodSugarController = TextEditingController();
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
}
