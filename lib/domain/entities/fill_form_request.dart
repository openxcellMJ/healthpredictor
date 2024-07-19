class FillFormRequest {
  String? full_name;
  String? email;
  String? gender;
  int? age;
  int? heightCm;
  int? weightKg;
  int? averageSleepHours;
  String? lastPhysicalExam;
  int? dailyWaterIntakeLitres;
  int? stepsCountPerDay;
  int? dailyExerciseHours;
  int? workHours;
  int? systolicPressure;
  int? diastolicPressure;
  int? heartRateBpm;
  int? bloodSugarLevelsMgDl;
  List<String>? medicalHistory;
  List<String>? heredityDiseases;
  List<String>? smokingStatus;
  List<String>? alcoholConsumption;
  List<String>? physicalActivityLevel;
  List<String>? dietType;
  List<String>? stressLevel;
  List<String>? currentMedications;
  List<String>? frequencyOfCheckups;
  List<String>? typeOfPhysicalActivities;

  FillFormRequest(
      {this.full_name,
      this.email,
      this.gender,
      this.age,
      this.heightCm,
      this.weightKg,
      this.averageSleepHours,
      this.lastPhysicalExam,
      this.dailyWaterIntakeLitres,
      this.stepsCountPerDay,
      this.dailyExerciseHours,
      this.workHours,
      this.systolicPressure,
      this.diastolicPressure,
      this.heartRateBpm,
      this.bloodSugarLevelsMgDl,
      this.medicalHistory,
      this.heredityDiseases,
      this.smokingStatus,
      this.alcoholConsumption,
      this.physicalActivityLevel,
      this.dietType,
      this.stressLevel,
      this.currentMedications,
      this.frequencyOfCheckups,
      this.typeOfPhysicalActivities});

  FillFormRequest.fromJson(Map<String, dynamic> json) {
    full_name = json['full_name'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    heightCm = json['height_cm'];
    weightKg = json['weight_kg'];
    averageSleepHours = json['average_sleep_hours'];
    lastPhysicalExam = json['last_physical_exam'];
    dailyWaterIntakeLitres = json['daily_water_intake_litres'];
    stepsCountPerDay = json['steps_count_per_day'];
    dailyExerciseHours = json['daily_exercise_hours'];
    workHours = json['work_hours'];
    systolicPressure = json['systolic_pressure'];
    diastolicPressure = json['diastolic_pressure'];
    heartRateBpm = json['heart_rate_bpm'];
    bloodSugarLevelsMgDl = json['blood_sugar_levels_mg_dl'];
    medicalHistory = json['medical_history'].cast<String>();
    heredityDiseases = json['heredity_diseases'].cast<String>();
    smokingStatus = json['smoking_status'].cast<String>();
    alcoholConsumption = json['alcohol_consumption'].cast<String>();
    physicalActivityLevel = json['physical_activity_level'].cast<String>();
    dietType = json['diet_type'].cast<String>();
    stressLevel = json['stress_level'].cast<String>();
    currentMedications = json['current_medications'].cast<String>();
    frequencyOfCheckups = json['frequency_of_checkups'].cast<String>();
    typeOfPhysicalActivities = json['type_of_physical_activities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = full_name;
    data['email'] = email;
    data['gender'] = gender;
    data['age'] = age;
    data['height_cm'] = heightCm;
    data['weight_kg'] = weightKg;
    data['average_sleep_hours'] = averageSleepHours;
    data['last_physical_exam'] = lastPhysicalExam;
    data['daily_water_intake_litres'] = dailyWaterIntakeLitres;
    data['steps_count_per_day'] = stepsCountPerDay;
    data['daily_exercise_hours'] = dailyExerciseHours;
    data['work_hours'] = workHours;
    data['systolic_pressure'] = systolicPressure;
    data['diastolic_pressure'] = diastolicPressure;
    data['heart_rate_bpm'] = heartRateBpm;
    data['blood_sugar_levels_mg_dl'] = bloodSugarLevelsMgDl;
    data['medical_history'] = medicalHistory;
    data['heredity_diseases'] = heredityDiseases;
    data['smoking_status'] = smokingStatus;
    data['alcohol_consumption'] = alcoholConsumption;
    data['physical_activity_level'] = physicalActivityLevel;
    data['diet_type'] = dietType;
    data['stress_level'] = stressLevel;
    data['current_medications'] = currentMedications;
    data['frequency_of_checkups'] = frequencyOfCheckups;
    data['type_of_physical_activities'] = typeOfPhysicalActivities;
    return data;
  }
}
