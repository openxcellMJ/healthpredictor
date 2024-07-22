import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/app_widgets.dart';
import '../../../custom_widgets/custom_edittext.dart';
import '../../../domain/entities/fill_form_request.dart';
import '../../../utils/utils.dart';
import '../../../values/app_colors.dart';
import '../../../values/strings_name.dart';
import '../../controller/main/home_controller.dart';

class ReportFormFiledPage extends GetView<HomeController> {
  const ReportFormFiledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppWidgets.appBar(true, title: 'strFillTheForm'.tr),
      body: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(background: Colors.white, primary: AppColors.gradientMiddle, secondary: AppColors.gradientMiddle),
        ),
        child: Obx(
          () => Stepper(
            elevation: 0,
            type: StepperType.horizontal,
            margin: EdgeInsets.zero,
            currentStep: controller.activeCurrentStep.value,
            onStepCancel: () {
              if (controller.activeCurrentStep.value == 0) {
                return;
              }
              controller.activeCurrentStep.value -= 1;
            },
            onStepContinue: () {
              // if (controller.activeCurrentStep.value < (5 - 1)) {
              //   controller.activeCurrentStep.value += 1;
              // }
              if (controller.activeCurrentStep.value < (5 - 1)) {
                if (_validateStep(controller.activeCurrentStep.value)) {
                  controller.activeCurrentStep.value += 1;
                }
              }
            },
            onStepTapped: (value) {
              if (_validateStep(controller.activeCurrentStep.value)) {
                controller.activeCurrentStep.value = value;
              }

              // controller.activeCurrentStep.value = value;
            },
            controlsBuilder: (context, details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: AppColors.gradientMiddle, width: 0.5), color: AppColors.gradientStart),
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        style: Get.theme.elevatedButtonTheme.style?.copyWith(shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))), backgroundColor: const MaterialStatePropertyAll(Colors.white)),
                        child: Text(
                          "Back",
                          style: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.gradientMiddle, fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientMiddle,
                            AppColors.gradientEnd,
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        style: Get.theme.elevatedButtonTheme.style?.copyWith(shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0)))), backgroundColor: const MaterialStatePropertyAll(Colors.transparent)),
                        child: Text(
                          "Next",
                          style: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.colorWhite, fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            steps: [
              Step(
                  state: controller.activeCurrentStep.value <= 0 ? StepState.editing : StepState.complete,
                  isActive: controller.activeCurrentStep.value >= 0,
                  title: AppWidgets.setTextWidget('', align: TextAlign.start, lines: 3, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFontTitle, fontSize: 16.sp)),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWidgets.setTextWidget('Personal Information', align: TextAlign.start, lines: 1, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFont, fontSize: 20)),
                      const SizedBox(height: 10),
                      CustomEditText(textInputAction: TextInputAction.next, hintText: 'First Name', controller: controller.firstNameController, fieldType: StringNames.normalField, type: TextInputType.text),
                      CustomEditText(controller: controller.emailController, hintText: 'Email', type: TextInputType.emailAddress, fieldType: StringNames.emailField, textInputAction: TextInputAction.next),
                      _buildDropdownField('Gender', ['Male', 'Female', 'Other'], controller.gender.value, (String? newValue) {}),
                      CustomEditText(controller: controller.ageController, hintText: 'Age', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.heightController, hintText: 'Height (cm)', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.weightController, hintText: 'Weight (kg)', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.done),
                      const SizedBox(height: 15),
                    ],
                  )),
              Step(
                  state: controller.activeCurrentStep.value <= 1 ? StepState.editing : StepState.complete,
                  isActive: controller.activeCurrentStep.value >= 1,
                  title: AppWidgets.setTextWidget('', align: TextAlign.start, lines: 3, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFontTitle, fontSize: 16.sp)),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWidgets.setTextWidget('Lifestyle', align: TextAlign.start, lines: 1, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFont, fontSize: 20)),
                      const SizedBox(height: 10),
                      CustomEditText(controller: controller.sleepHoursController, hintText: 'Average hours of sleep per night', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.waterIntakeController, hintText: 'Daily Water Intake (litres)', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.stepsCountController, hintText: 'Steps Count (Per Day)', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.exerciseHoursController, hintText: 'Minutes of exercise per day', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.workHoursController, hintText: 'Work Hours', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.done),
                      GestureDetector(
                          onTap: () {
                            controller.selectDateForCreateAgenda(context);
                          },
                          child: CustomEditText(controller: controller.physicalExamController, enabled: false, hintText: 'Last Physical Exam', type: TextInputType.datetime, textInputAction: TextInputAction.done, readOnly: true)),
                      const SizedBox(height: 15),
                    ],
                  )),
              Step(
                  state: controller.activeCurrentStep.value <= 2 ? StepState.editing : StepState.complete,
                  isActive: controller.activeCurrentStep.value >= 2,
                  title: AppWidgets.setTextWidget('', align: TextAlign.start, lines: 3, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFontTitle, fontSize: 16.sp)),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWidgets.setTextWidget('Health Details', align: TextAlign.start, lines: 1, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFont, fontSize: 20)),
                      const SizedBox(height: 10),
                      CustomEditText(controller: controller.heartRateController, hintText: 'Heart Rate (bpm)', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.bloodSugarController, hintText: 'Blood Sugar Levels (mg/dL)', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.systolicController, hintText: 'Systolic Pressure (mmHg)', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.diastolicController, hintText: 'Diastolic Pressure (mmHg)', type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.done),
                      const SizedBox(height: 15),
                    ],
                  )),
              Step(
                  state: controller.activeCurrentStep.value <= 3 ? StepState.editing : StepState.complete,
                  isActive: controller.activeCurrentStep.value >= 3,
                  title: AppWidgets.setTextWidget('', align: TextAlign.start, lines: 3, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFontTitle, fontSize: 16.sp)),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWidgets.setTextWidget('Medical History and Habits', align: TextAlign.start, lines: 1, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFont, fontSize: 20)),
                      const SizedBox(height: 10),
                      _buildDropdownField('Medical History', ['Hypertension', 'Asthma', 'High Cholesterol'], controller.medicalHistory.value, (String? newValue) {}),
                      _buildDropdownField('Heredity Diseases', ['Diabetes', 'Heart Disease'], controller.heredityDiseases.value, (String? newValue) {}),
                      _buildDropdownField('Smoking Status', ['Never', 'Former', 'Current'], controller.smokingStatus.value, (String? newValue) {
                        controller.smokingStatus.value = newValue!;
                      }),
                      _buildDropdownField('Alcohol Consumption', ['None', 'Occasional', 'Regular'], controller.alcoholConsumption.value, (String? newValue) {}),
                      _buildDropdownField('Physical Activity Level', ['Sedentary', 'Lightly Active', 'Moderately Active', 'Very Active'], controller.physicalActivityLevel.value, (String? newValue) {}),
                      const SizedBox(height: 15),
                    ],
                  )),
              Step(
                  state: StepState.complete,
                  isActive: controller.activeCurrentStep.value >= 4,
                  title: AppWidgets.setTextWidget('', align: TextAlign.start, lines: 3, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFontTitle, fontSize: 16.sp)),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWidgets.setTextWidget('Additional Information', align: TextAlign.start, lines: 1, styles: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.blackFont, fontSize: 20)),
                      const SizedBox(height: 10),
                      _buildDropdownField('Diet Type', ['Omnivore', 'Vegetarian', 'Vegan', 'Pescatarian'], controller.dietType.value, (String? newValue) {}),
                      _buildDropdownField('Stress Level', ['Low', 'Moderate', 'High'], controller.stressLevel.value, (String? newValue) {}),
                      _buildDropdownField('Current Medications', ['Metformin', 'Aspirin'], controller.currentMedications.value, (value) {}),
                      _buildDropdownField('Frequency of Checkups', ['Annually', 'Biannually', 'Rarely'], controller.frequencyOfCheckups.value, (String? newValue) {}),
                      _buildDropdownField('Type of Physical Activities', ['Running', 'Yoga', 'Weightlifting'], controller.physicalActivities.value, (value) {}),
                      const SizedBox(height: 15),
                    ],
                  ))
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType keyboardType, {var isEnable = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: isEnable,
        style: Get.theme.textTheme.bodyMedium?.copyWith(color: AppColors.black, fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          hintStyle: Get.theme.textTheme.bodyMedium?.copyWith(color: AppColors.shadowColor, fontSize: 12.sp),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String currentValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentValue,
            isDense: true,
            onChanged: onChanged,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: Get.theme.textTheme.bodyMedium?.copyWith(color: AppColors.black, fontSize: 14)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  setupApicallData() {
    var form = FillFormRequest();
    form.full_name = controller.firstNameController.text;
    form.email = controller.emailController.text;
    form.gender = controller.gender.value;
    form.age = int.parse(controller.ageController.text);
    form.heightCm = int.parse(controller.heightController.text);
    form.weightKg = int.parse(controller.weightController.text);
    form.averageSleepHours = int.parse(controller.sleepHoursController.text);
    form.dailyWaterIntakeLitres = int.parse(controller.waterIntakeController.text);
    form.stepsCountPerDay = int.parse(controller.stepsCountController.text);
    form.dailyExerciseHours = int.parse(controller.exerciseHoursController.text);
    form.workHours = int.parse(controller.workHoursController.text);
    form.lastPhysicalExam = controller.physicalExamController.text;
    form.heartRateBpm = int.parse(controller.heartRateController.text);
    form.bloodSugarLevelsMgDl = int.parse(controller.bloodSugarController.text);
    form.systolicPressure = int.parse(controller.systolicController.text);
    form.diastolicPressure = int.parse(controller.diastolicController.text);
    form.medicalHistory = [controller.medicalHistory.value.toString()];
    form.heredityDiseases = [controller.heredityDiseases.value];
    form.smokingStatus = [controller.smokingStatus.value];
    form.alcoholConsumption = [controller.alcoholConsumption.value];
    form.physicalActivityLevel = [controller.physicalActivityLevel.value];
    form.dietType = [controller.dietType.value];
    form.stressLevel = [controller.stressLevel.value];
    form.currentMedications = [controller.currentMedications.value];
    form.frequencyOfCheckups = [controller.frequencyOfCheckups.value];
    form.typeOfPhysicalActivities = [controller.physicalActivities.value];
    controller.fillFormApi(form);
    print("tests=>${form.toJson()}");
  }

  bool _validateStep(int currentStep) {
    print("etetet=>${currentStep}");
    switch (currentStep) {
      case 0:
        if (controller.firstNameController.text.trim().isEmpty) {
          Utils.showSnackBar("Enter valid full name", color: AppColors.textFieldErrorText);
          return false;
        } else if (!FormValidator.validateEmail(controller.emailController.text.trim())) {
          Utils.showSnackBar("Enter valid email address", color: AppColors.textFieldErrorText);
          return false;
        }
        break;
      case 1:
        // Add validation logic for step 1 here
        break;
      case 2:
        // Add validation logic for step 2 here
        break;
      case 3:
        setupApicallData();

        // Add validation logic for step 3 here
        break;
      case 4:
        break;
    }
    return true;
  }
}

//Column(
//             children: [
//               _buildTextField(controller.firstNameController, 'First Name', TextInputType.text),
//               _buildTextField(controller.lastNameController, 'Last Name', TextInputType.text),
//               _buildTextField(controller.emailController, 'Email', TextInputType.emailAddress),
//               _buildDropdownField('Gender', ['Male', 'Female', 'Other'], controller.gender.value, (String? newValue) {}),
//               _buildTextField(controller.ageController, 'Age', TextInputType.number),
//               _buildTextField(controller.heightController, 'Height (cm)', TextInputType.number),
//               _buildTextField(controller.weightController, 'Weight (kg)', TextInputType.number),
//               _buildTextField(controller.sleepHoursController, 'Average Sleep Hours', TextInputType.number),
//               _buildTextField(controller.physicalExamController, 'Last Physical Exam', TextInputType.datetime),
//               _buildTextField(controller.waterIntakeController, 'Daily Water Intake (litres)', TextInputType.number),
//               _buildTextField(controller.stepsCountController, 'Steps Count (Per Day)', TextInputType.number),
//               _buildTextField(controller.exerciseHoursController, 'Daily Exercise Hours', TextInputType.number),
//               _buildTextField(controller.workHoursController, 'Work Hours', TextInputType.number),
//               _buildTextField(controller.systolicController, 'Systolic Pressure (mmHg)', TextInputType.number),
//               _buildTextField(controller.diastolicController, 'Diastolic Pressure (mmHg)', TextInputType.number),
//               _buildTextField(controller.heartRateController, 'Heart Rate (bpm)', TextInputType.number),
//               _buildTextField(controller.bloodSugarController, 'Blood Sugar Levels (mg/dL)', TextInputType.number),
//               _buildDropdownField('Medical History', ['Hypertension', 'Asthma', 'High Cholesterol'], controller.medicalHistory.value, (String? newValue) {}),
//               _buildDropdownField('Heredity Diseases', ['Diabetes', 'Heart Disease'], controller.heredityDiseases.value, (String? newValue) {}),
//               _buildDropdownField('Smoking Status', ['Never', 'Former', 'Current'], controller.smokingStatus.value, (String? newValue) {
//                 controller.smokingStatus.value = newValue!;
//               }),
//               _buildDropdownField('Alcohol Consumption', ['None', 'Occasional', 'Regular'], controller.alcoholConsumption.value, (String? newValue) {}),
//               _buildDropdownField('Physical Activity Level', ['Sedentary', 'Lightly Active', 'Moderately Active', 'Very Active'], controller.physicalActivityLevel.value, (String? newValue) {}),
//               _buildDropdownField('Diet Type', ['Omnivore', 'Vegetarian', 'Vegan', 'Pescatarian'], controller.dietType.value, (String? newValue) {}),
//               _buildDropdownField('Stress Level', ['Low', 'Moderate', 'High'], controller.stressLevel.value, (String? newValue) {}),
//               _buildDropdownField('Current Medications', ['Metformin', 'Aspirin'], controller.currentMedications.value, (value) {}),
//               _buildDropdownField('Frequency of Checkups', ['Annually', 'Biannually', 'Rarely'], controller.frequencyOfCheckups.value, (String? newValue) {}),
//               _buildDropdownField('Type of Physical Activities', ['Running', 'Yoga', 'Weightlifting'], controller.physicalActivities.value, (value) {}),
//               SizedBox(height: 20),
//               AppWidgets.setElevatedButtonNew("strSubmit".tr, () {
//
//
//
//               })
//             ],
//           )
