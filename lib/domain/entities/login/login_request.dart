class LoginRequestModel {
  String? input;
  String? inputType;
  String? password;
  DeviceInfo? deviceInfo;

  LoginRequestModel(
      {this.input, this.inputType, this.password, this.deviceInfo});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    input = json['input'];
    inputType = json['inputType'];
    password = json['password'];
    deviceInfo = json['deviceInfo'] != null
        ? new DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['input'] = this.input;
    data['inputType'] = this.inputType;
    data['password'] = this.password;
    if (this.deviceInfo != null) {
      data['deviceInfo'] = this.deviceInfo!.toJson();
    }
    return data;
  }
}

class DeviceInfo {
  String? fcmToken;
  String? deviceId;
  String? deviceName;
  String? deviceType;
  String? voipToken;
  DeviceInfo({this.fcmToken, this.deviceId, this.deviceName, this.deviceType, this.voipToken});


  DeviceInfo.fromJson(Map<String, dynamic> json) {
    fcmToken = json['fcmToken'];
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    deviceType = json['deviceType'];
    voipToken = json['voipToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fcmToken'] = this.fcmToken;
    data['deviceId'] = this.deviceId;
    data['deviceName'] = this.deviceName;
    data['deviceType'] = deviceType;
    data['voipToken'] = voipToken;
    return data;
  }
}
