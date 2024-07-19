import 'package:envitely/domain/entities/login/UserDetails.dart';

class LoginResponseModel {
  UserDetails? user;
  String? token;
  bool? newDevice;

  LoginResponseModel({this.user, this.token, this.newDevice});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserDetails.fromJson(json['user']) : null;
    token = json['token'];
    newDevice = json['newDevice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['newDevice'] = newDevice;
    return data;
  }
}


