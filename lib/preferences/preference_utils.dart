import 'dart:convert';

import 'package:envitely/domain/entities/login/UserDetails.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenceUtils {
  static SharedPreferences? _preferences;

  static const _keyToken = 'Token';
  static const _keyEmail = 'email';
  static const _keyIsLogin = 'isLogin';
  static const _keyIsTheme = 'Theme';
  static const _keyIsWelcome = 'isWelcome';
  static const _keyFCMToken = 'FCMToken';
  static const _loginUser = 'LoginUser';
  static const _keyVOIPToken = 'VOIPToken';
  static const _appleUser = 'AppleUser';
  static const _appLanguage = 'AppLanguage';

  static const _callingDetails = '_callingDetails';

  static const _keyIsBetaUser = 'isBetaUser';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setToken(String token) async =>
      await _preferences?.setString(_keyToken, token);

  static String getToken() => _preferences?.getString(_keyToken) ?? "";
 //  static String getToken() => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTEzYTUzNjk4Mjk4ZDg5ZjY1Nzg1MTIiLCJpYXQiOjE3MDE5Mzk1ODcsImV4cCI6MTczMzQ3NTU4N30.6uJ7th3jyUN7KxDUgpHMeYsCj2GH6uNKGkqx5hr_R_Q" ?? "";

  static Future setEmail(String email) async =>
      await _preferences?.setString(_keyEmail, email);

  static String getEmail() => _preferences?.getString(_keyEmail) ?? " ";

  static Future setFCMToken(String fcmToken) async =>
      await _preferences?.setString(_keyFCMToken, fcmToken);

  static String getFCMToken() => _preferences?.getString(_keyFCMToken) ?? "";

  static Future setAppLanguage(String appLanguage) async =>
      await _preferences?.setString(_appLanguage, appLanguage);

  static String getAppLanguage() => _preferences?.getString(_appLanguage) ?? "en";

  static Future setVOIPToken(String token) async =>
      await _preferences?.setString(_keyVOIPToken, token);

  static String getVOIPToken() => _preferences?.getString(_keyVOIPToken) ?? "";

  static Future setIsLogin(bool amount) async =>
      await _preferences?.setBool(_keyIsLogin, amount);

  static bool getIsLogin() => _preferences?.getBool(_keyIsLogin) ?? false;

  // static Future setIsBetaLogin(bool amount) async =>
  //     await _preferences?.setBool(_keyIsBetaUser, amount);
  //
  // static bool getIsBetaLogin() => _preferences?.getBool(_keyIsBetaUser) ?? false;

  static Future setIsWelcome(bool amount) async =>
      await _preferences?.setBool(_keyIsWelcome, amount);

  static bool getIsWelcome() => _preferences?.getBool(_keyIsWelcome) ?? false;

  static Future setLoginUser(dynamic value) async {
    await _preferences?.setString(_loginUser, json.encode(value));

    // Get current user
    final currentUser = PreferenceUtils.getLoginUser();

    // // Get chat manager
    // final chatManager = Get.find<ChatManager>();
    //
    // // Check if current user is login
    // if (currentUser.sId != null) {
    //   // Start chat manager
    //   chatManager.start(currentUserId: currentUser.sId!);
    // } else {
    //   // Stop chat manager
    //   Get.find<ChatManager>().stop();
    // }
  }

  static Future setLoginAppleUser(dynamic value) async =>
      await _preferences?.setString(_appleUser, json.encode(value));

  static UserDetails getLoginUser() {
    if ((_preferences?.getString(_loginUser) != null) &&
        _preferences?.getString(_loginUser)?.isNotEmpty == true) {
      Map<String, dynamic>? userMap =
          json.decode(_preferences?.getString(_loginUser) ?? "");
      if (userMap != null) {
        return UserDetails.fromJson(userMap);
      } else {
        return UserDetails();
      }
    } else {
      return UserDetails();
    }
  }

  static Future setThemeData(bool theme) async =>
      await _preferences?.setBool(_keyIsTheme, theme);

  static bool getThemeData() => _preferences?.getBool(_keyIsTheme) ?? false;

  static clearPreference() {
    _preferences?.clear();

    // Stop chat manager
    // Get.find<ChatManager>().stop();
  }

  static Future setCallingDetails(dynamic value) async =>
      await _preferences?.setString(_callingDetails, json.encode(value));
  static Future removeCallingDetails() async =>
      await _preferences?.remove(_callingDetails);

  // static CallUserDetails? getCallingDetails() {
  //   if ((_preferences?.getString(_callingDetails) != null) &&
  //       _preferences?.getString(_callingDetails)?.isNotEmpty == true) {
  //     Map<String, dynamic>? userMap =
  //         json.decode(_preferences?.getString(_callingDetails) ?? "");
  //
  //     if (userMap != null) {
  //       return CallUserDetails.fromJson(userMap);
  //     } else {
  //       return null;
  //     }
  //   }
  // }
}
