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

  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController(text: "18");
  TextEditingController heightController = TextEditingController(text: "1");
  TextEditingController weightController = TextEditingController(text: "1");
  TextEditingController sleepHoursController = TextEditingController(text: "1");
  TextEditingController physicalExamController = TextEditingController();
  TextEditingController waterIntakeController = TextEditingController();
  TextEditingController stepsCountController = TextEditingController();
  TextEditingController exerciseHoursController = TextEditingController();
  TextEditingController workHoursController = TextEditingController();
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();
  TextEditingController heartRateController = TextEditingController();
  TextEditingController bloodSugarController = TextEditingController();
  final TextEditingController chatController = TextEditingController();
  var gender = 'Male'.obs;
  var medicalHistory = 'Essential'.obs;
  var heredityDiseases = 'Diabetes'.obs;
  var smokingStatus = 'Never Smoked'.obs;
  var alcoholConsumption = 'Never'.obs;
  var physicalActivityLevel = 'None'.obs;
  var dietType = 'Balanced (Varied diet with all food groups)'.obs;
  var stressLevel = 'No Stress'.obs;
  var currentMedications = 'Metformin'.obs;
  var frequencyOfCheckups = 'Never'.obs;
  var physicalActivities = 'Walking'.obs;
  var mySelectedAgendaDate = DateTime.now().obs;
  var activeCurrentStep = 0.obs;
  var cIndex = 0.obs;
  var result = "".obs;
  var chats = [].obs;
  var isBotTyping = false.obs;
  var isListen = true.obs;
  var sessionId = "".obs;
  ScrollController scrollController = ScrollController();

  var stressList = ["No Stress", "Low Stress", "Moderate Stress", "High Stress", "Very High Stress", "Extreme Stress", "None"];

  var smokingList = ["Current Smoker", "Former Smoker", "Never Smoked", "Occasional Smoker", "Heavy Smoker", "Light Smoker", "None"];

  var medicalHistoryList = [
    "Essential",
    "Secondary",
    "Coronary Artery Disease",
    "Heart Attack",
    "Congestive Heart Failure",
    "Arrhythmia",
    "Asthma",
    "Chronic Obstructive Pulmonary Disease (COPD)",
    "Emphysema",
    "Bronchitis",
    "Diabetes - Type 1",
    "Diabetes - Type 2",
    "Diabetes - Gestational",
    "High Cholesterol",
    "Ischemic Stroke",
    "Hemorrhagic Stroke",
    "Transient Ischemic Attack",
    "Epilepsy",
    "Migraines",
    "Irritable Bowel Syndrome (IBS)",
    "Crohn's Disease",
    "Ulcerative Colitis",
    "Gastroesophageal Reflux Disease (GERD)",
    "Peptic Ulcer",
    "Rheumatoid Arthritis",
    "Lupus",
    "Multiple Sclerosis",
    "Hashimoto's Thyroiditis",
    "Depression",
    "Anxiety",
    "Bipolar Disorder",
    "Schizophrenia",
    "Chronic Kidney Disease",
    "Acute Kidney Injury",
    "Nephritis",
    "Breast Cancer",
    "Prostate Cancer",
    "Lung Cancer",
    "Colorectal Cancer",
    "Skin Cancer",
    "Parkinson's Disease",
    "Alzheimer’s Disease",
    "Food Allergies",
    "Drug Allergies",
    "Environmental Allergies",
  ];

  var heredityList = [
    'Diabetes',
    'Heart Disease',
    "Hypertension",
    "Cancer",
    "Stroke",
    "Asthma",
    "Alzheimer's Disease",
    "Parkinson's Disease",
    "Autoimmune Disease",
    "Mental Illness (e.g., Depression, Anxiety)",
    "Breast Cancer",
    "Prostate Cancer",
    "Colon Cancer",
    "Ovarian Cancer",
    "Pancreatic Cancer",
    "Huntington's Disease",
    "Cystic Fibrosis",
    "Sickle Cell Anemia",
    "Hemophilia",
    "Thalassemia",
    "Muscular Dystrophy",
    "Spinal Muscular Atrophy",
    "Marfan Syndrome",
    "Tay-Sachs Disease",
    "Down Syndrome",
    "Turner Syndrome",
    "Klinefelter Syndrome",
    "None"
  ];

  var alcoholList = [
    "Daily",
    "Weekly",
    "Monthly",
    "Occasional",
    "Rarely",
    "Never",
    "Former Drinker",
  ];

  var physicalActivityLevelList = [
    "None",
    "Sedentary (Little to no exercise)",
    "Lightly Active (Light exercise/sports 1-3 days/week)",
    "Moderately Active (Moderate exercise/sports 3-5 days/week)",
    "Very Active (Hard exercise/sports 6-7 days a week)",
    "Extra Active (Very hard exercise/physical job)",
  ];

  var dietList = [
    "Balanced (Varied diet with all food groups)",
    "Vegetarian (No meat)",
    "Vegan (No animal products)",
    "Low-Carb (Reduced carbohydrate intake)",
    "Low-Fat (Reduced fat intake)",
    "High-Protein (Increased protein intake)",
    "Ketogenic (High-fat, low-carb)",
    "Mediterranean (Emphasis on fruits, vegetables, and olive oil)",
    "Paleo (Focus on lean meats, fruits, and vegetables)",
    "Gluten-Free (No gluten-containing foods)",
    "Raw Food (Uncooked, unprocessed foods)"
  ];

  var checkupList = <String>[
    "Never",
    "Daily",
    "Weekly",
    "Monthly",
    "Quarterly",
    "Semi-Annually",
    "Annually",
    "Every Few Years",
    "As Needed",
  ];

  var medicationsList = <String>[
    'Metformin',
    'Aspirin',
    'Ibuprofen',
    'Acetaminophen',
    'Lisinopril',
    'Atorvastatin',
    'Omeprazole',
    'Levothyroxine',
    'Amlodipine',
    'Albuterol (Ventolin, ProAir)',
    'Hydrochlorothiazide',
    'Simvastatin',
    'Antibiotics',
    'Antidepressants',
    'Antihypertensives',
    'Antidiabetics',
    'Pain Relievers',
    'Hormone Replacement Therapy',
    'Anticoagulants',
    'Inhalers',
    'Antacids',
    'Diuretics',
    'Anti-anxiety Medications',
    'Anti-seizure Medications',
    'Blood Pressure Medications',
    'Cholesterol Medications',
    'Allergy Medications',
    'Insulin'
  ];

  var typeOfPhysicalActivitiesList = <String>[
    "Walking",
    "Running",
    "Cycling",
    "Swimming",
    "Strength Training",
    "Yoga",
    "Pilates",
    "Aerobics",
    "Team Sports (e.g., Soccer, Basketball)",
    "Outdoor Activities (e.g., Hiking, Climbing)",
    "Stretching",
    "Dance",
    "Martial Arts",
    "Gym Workouts",
  ];

  clearFormValues() {
    firstNameController.clear();
    emailController.clear();
    firstNameController = TextEditingController();
    emailController = TextEditingController();
    ageController = TextEditingController(text: "18");
    heightController = TextEditingController(text: "1");
    weightController = TextEditingController(text: "1");
    sleepHoursController = TextEditingController(text: "1");
    physicalExamController = TextEditingController();
    waterIntakeController = TextEditingController();
    stepsCountController = TextEditingController();
    exerciseHoursController = TextEditingController();
    workHoursController = TextEditingController();
    systolicController = TextEditingController();
    diastolicController = TextEditingController();
    heartRateController = TextEditingController();
    bloodSugarController = TextEditingController();
    mySelectedAgendaDate.value = DateTime.now();
    gender.value = 'Male';
    medicalHistory.value = 'Essential';
    heredityDiseases.value = 'Diabetes';
    smokingStatus.value = 'Never Smoked';
    alcoholConsumption.value = 'Never';
    physicalActivityLevel.value = 'None';
    dietType.value = 'Balanced (Varied diet with all food groups)';
    stressLevel.value = 'No Stress';
    currentMedications.value = 'Metformin';
    frequencyOfCheckups.value = 'Never';
    physicalActivities.value = 'Walking';
    activeCurrentStep.value = 0;
  }

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
    AppWidgets.showProgress();
    try {
      var response = await mainUseCase.fillReport(loginRequestModel);
      AppWidgets.closeProgress();
      if (response != null) {
        Utils.hideKeyboard();
        sessionId.value = response.sessionId ?? "";
        Get.to(FormAnswerPage(), arguments: response.predictions);
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
    //_scrollToBottom();
  }

  // _scrollToBottom() {
  //   if (scrollController.hasClients) scrollController.jumpTo(scrollController.position.maxScrollExtent);
  // }

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
