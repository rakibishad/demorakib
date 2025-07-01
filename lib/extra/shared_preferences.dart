import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_constants.dart';
import 'app_variables.dart';

class AppPreferences {
  static AppPreferences shared = AppPreferences();
  SharedPreferences? _prefs;

  initialisePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    isLoggedIn = await getBoolSharedPreferences(AppConstants.alreadyLogin);

    if (await getSharedPreferences(AppConstants.accessTokenKey) != null) {
      accessToken =
          "${await getSharedPreferences(AppConstants.accessTokenKey)}";
    }
    if (await getSharedPreferences(AppConstants.workingId) != null) {
      workingId =
          "${await getSharedPreferences(AppConstants.workingId)}";
    }
    debugPrint('INITSharedPre $isLoggedIn');
    debugPrint('INITSharedPre $accessToken');
    debugPrint('INITSharedPre $workingId');
  }

  removeUser() async {
    if (_prefs == null) initialisePrefs();
    await _prefs?.remove(AppConstants.user);
  }

  saveSharedPreferences(String key, String value) {
    if (_prefs == null) initialisePrefs();
    _prefs?.setString(key, value);
  }

  removePreferences(String key) {
    if (_prefs == null) initialisePrefs();
    _prefs?.remove(key);
  }

  saveBoolSharedPreferences(String key, bool value) {
    if (_prefs == null) initialisePrefs();
    _prefs?.setBool(key, value);
  }

  getSharedPreferences(String key) {
    if (_prefs == null) initialisePrefs();
    return _prefs?.getString(key);
  }

  getBoolSharedPreferences(String key) {
    if (_prefs == null) initialisePrefs();
    return _prefs?.getBool(key) ?? false;
  }
}
