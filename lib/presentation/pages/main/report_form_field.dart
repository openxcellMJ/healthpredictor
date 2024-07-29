import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

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
              Utils.hideKeyboard();
              if (controller.activeCurrentStep.value < (5 - 1)) {
                if (_validateStep(controller.activeCurrentStep.value)) {
                  controller.activeCurrentStep.value += 1;
                }
              }
            },
            onStepTapped: (value) {
              Utils.hideKeyboard();
              if (_validateStep(controller.activeCurrentStep.value)) {
                controller.activeCurrentStep.value = value;
              }

              // controller.activeCurrentStep.value = value;
            },
            controlsBuilder: (context, details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Obx(
                    () => Visibility(
                      visible: controller.activeCurrentStep.value != 0,
                      child: Expanded(
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
                    ),
                  ),
                  Obx(
                    () => Visibility(visible: controller.activeCurrentStep.value != 0, child: const SizedBox(width: 10)),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.cIndex.value < 3,
                      child: Expanded(
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
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.cIndex.value == 3,
                      child: Expanded(
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
                            onPressed: () => setupApicallData(),
                            style: Get.theme.elevatedButtonTheme.style?.copyWith(shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0)))), backgroundColor: const MaterialStatePropertyAll(Colors.transparent)),
                            child: Text(
                              "Submit",
                              style: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.colorWhite, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
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
                      CustomEditText(textInputAction: TextInputAction.next, hintText: 'Full Name', controller: controller.firstNameController, fieldType: StringNames.normalField, type: TextInputType.text),
                      CustomEditText(controller: controller.emailController, hintText: 'Email', type: TextInputType.emailAddress, fieldType: StringNames.emailField, textInputAction: TextInputAction.done),
                      _buildDropdownField('Gender', ['Male', 'Female', 'Other'], controller.gender.value, (String? newValue) {
                        controller.gender.value = newValue!;
                      }),
                      CustomEditText(controller: controller.ageController, hintText: 'Age', type: TextInputType.number, maxLength: 3, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.heightController, hintText: 'Height (cm)', type: const TextInputType.numberWithOptions(decimal: true), maxLength: 5, fieldType: StringNames.emailField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.weightController, hintText: 'Weight (kg)', type: const TextInputType.numberWithOptions(decimal: true), maxLength: 5, fieldType: StringNames.emailField, textInputAction: TextInputAction.done),
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
                      CustomEditText(controller: controller.sleepHoursController, hintText: 'Average hours of sleep per night', maxLength: 5, type: const TextInputType.numberWithOptions(decimal: true), fieldType: StringNames.emailField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.waterIntakeController, hintText: 'Daily Water Intake (litres)', maxLength: 4, type: const TextInputType.numberWithOptions(decimal: true), fieldType: StringNames.emailField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.stepsCountController, hintText: 'Steps Count (Per Day)', maxLength: 5, type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.exerciseHoursController, hintText: 'Minutes of exercise per day', maxLength: 4, type: const TextInputType.numberWithOptions(decimal: true), fieldType: StringNames.emailField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.workHoursController, hintText: 'Work Hours', maxLength: 4, type: const TextInputType.numberWithOptions(decimal: true), fieldType: StringNames.emailField, textInputAction: TextInputAction.done),
                      GestureDetector(
                          onTap: () {
                            Utils.hideKeyboard();
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
                      CustomEditText(controller: controller.heartRateController, hintText: 'Heart Rate (bpm)', maxLength: 5, type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.bloodSugarController, hintText: 'Blood Sugar Levels (mg/dL)', maxLength: 4, type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.systolicController, hintText: 'Systolic Pressure (mmHg)', maxLength: 4, type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.next),
                      CustomEditText(controller: controller.diastolicController, hintText: 'Diastolic Pressure (mmHg)', maxLength: 4, type: TextInputType.number, fieldType: StringNames.phoneField, textInputAction: TextInputAction.done),
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
                      _buildDropdownField('Medical History', controller.medicalHistoryList, controller.medicalHistory.value, (String? newValue) {
                        controller.medicalHistory.value = newValue!;
                      }),
                      _buildDropdownField('Heredity Diseases', controller.heredityList, controller.heredityDiseases.value, (String? newValue) {
                        controller.heredityDiseases.value = newValue!;
                      }),
                      _buildDropdownField('Smoking Status', controller.smokingList, controller.smokingStatus.value, (String? newValue) {
                        controller.smokingStatus.value = newValue!;
                      }),
                      _buildDropdownField('Alcohol Consumption', controller.alcoholList, controller.alcoholConsumption.value, (String? newValue) {
                        controller.alcoholConsumption.value = newValue!;
                      }),
                      _buildDropdownField('Physical Activity Level', controller.physicalActivityLevelList, controller.physicalActivityLevel.value, (String? newValue) {
                        controller.physicalActivityLevel.value = newValue!;
                      }),
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
                      _buildDropdownField('Diet Type', controller.dietList, controller.dietType.value, (String? newValue) {
                        controller.dietType.value = newValue!;
                      }),
                      _buildDropdownField('Stress Level', controller.stressList, controller.stressLevel.value, (String? newValue) {
                        controller.stressLevel.value = newValue!;
                      }),
                      _buildDropdownField('Current Medications', controller.medicationsList, controller.currentMedications.value, (value) {
                        controller.currentMedications.value = value!;
                      }),
                      _buildDropdownField('Frequency of Checkups', controller.checkupList, controller.frequencyOfCheckups.value, (String? newValue) {
                        controller.frequencyOfCheckups.value = newValue!;
                      }),
                      _buildDropdownField('Type of Physical Activities', controller.typeOfPhysicalActivitiesList, controller.physicalActivities.value, (value) {
                        controller.physicalActivities.value = value!;
                      }),
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
            isExpanded: true,
            onChanged: onChanged,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: Get.theme.textTheme.bodyMedium?.copyWith(color: AppColors.black, fontSize: 14, overflow: TextOverflow.ellipsis)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  setupApicallData() {
    Utils.hideKeyboard();
    var form = FillFormRequest();
    form.full_name = controller.firstNameController.text;
    form.email = controller.emailController.text;
    form.gender = controller.gender.value;
    form.age = int.parse(controller.ageController.text);
    form.heightCm = double.parse(controller.heightController.text);
    form.weightKg = double.parse(controller.weightController.text);
    form.averageSleepHours = double.parse(controller.sleepHoursController.text);
    form.dailyWaterIntakeLitres = double.parse(controller.waterIntakeController.text);
    form.stepsCountPerDay = controller.stepsCountController.text.isNotEmpty ? int.parse(controller.stepsCountController.text) : 0;
    form.dailyExerciseHours = double.parse(controller.exerciseHoursController.text);
    form.workHours = double.parse(controller.workHoursController.text);
    form.lastPhysicalExam = controller.physicalExamController.text;
    form.heartRateBpm =controller.heartRateController.text.isNotEmpty ? int.parse(controller.heartRateController.text) : 0;
    form.bloodSugarLevelsMgDl = controller.bloodSugarController.text.isNotEmpty ? int.parse(controller.bloodSugarController.text) : 0;
    form.systolicPressure = controller.systolicController.text.isNotEmpty ? int.parse(controller.systolicController.text) : 0;
    form.diastolicPressure = controller.diastolicController.text.isNotEmpty ? int.parse(controller.diastolicController.text): 0;
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

    controller.cIndex.value = currentStep;

    switch (currentStep) {
      case 0:
        if (controller.firstNameController.text.trim().isEmpty) {
          Utils.showSnackBar("Enter valid full name", color: AppColors.textFieldErrorText);
          return false;
        } else if (!FormValidator.validateEmail(controller.emailController.text.trim())) {
          Utils.showSnackBar("Enter valid email address", color: AppColors.textFieldErrorText);
          return false;
        }else if (controller.ageController.text.trim().isEmpty || double.parse(controller.ageController.text.trim()) < double.parse(18.toString())) {
          Utils.showSnackBar("Enter a valid age that is greater than 18", color: AppColors.textFieldErrorText);
          return false;
        } else if (controller.heightController.text.trim().isEmpty || double.parse(controller.heightController.text.trim()) <= double.parse(1.toString())) {
          Utils.showSnackBar("Enter valid height that is greater than 1", color: AppColors.textFieldErrorText);
          return false;
        } else if (controller.weightController.text.trim().isEmpty || double.parse(controller.weightController.text.trim()) <= double.parse(1.toString())) {
          Utils.showSnackBar("Enter valid weight that is greater than 1", color: AppColors.textFieldErrorText);
          return false;
        }
        break;
      case 1:
        if (controller.sleepHoursController.text.trim().isNotEmpty  && (double.parse(controller.sleepHoursController.text.trim()) > double.parse(24.toString()))) {
          Utils.showSnackBar("Enter a valid sleep hour that is less than or equal 24", color: AppColors.textFieldErrorText);
          return false;
        }
        break;
      case 2:
        // Add validation logic for step 2 here
        break;
      case 3:
        // Add validation logic for step 3 here
        break;
      case 4:
        //setupApicallData();
        break;
    }
    return true;
  }

  Widget _buildMultiSelectField(String label, List<String> options, List<String> selectedItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Wrap(
          spacing: 5.0,
          children: options.map((String option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedItems.contains(option),
              onSelected: (bool selected) {
                if (selected) {
                  selectedItems.add(option);
                } else {
                  selectedItems.remove(option);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
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

//DropDownMultiSelect(
//
//                         selectedValuesStyle: const TextStyle(color: Colors.black),
//                         decoration: const InputDecoration(
//                           labelText: "Medical History",
//                           enabledBorder: OutlineInputBorder(borderRadius:
//                           BorderRadius.all(Radius.circular(4)), borderSide: BorderSide(color: Colors.grey, width: 1.5)),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(4)),
//                               borderSide: BorderSide(
//                                 color: Colors.blue,
//                                 width: 1.5,
//                               )),
//                         ),
//                         options: [
//                           'Hypertension',
//                           'Arrhythmia',
//                           'Heart Attack',
//                           "Asthma",
//                           'Chronic Obstructive Pulmonary Disease (COPD)',
//                           "High Cholesterol",
//                           "Diabetes",
//                           "Stroke",
//                           "Epilepsy",
//                           "Migraines",
//                           "Irritable Bowel Syndrome (IBS)",
//                           "Crohn's Disease",
//                           "Rheumatoid Arthritis",
//                           "Lupus",
//                           "Depression",
//                           "Anxiety"
//                         ],
//                         selectedValues: controller.currentMedicationsList.value,
//
//                         onChanged: (List<String> value) {
//                           //   value = selectedCheckBoxValue;
//                           print("${controller.currentMedicationsList.value}");
//                         },
//                         whenEmpty: 'Select Location',
//                       ),
