// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';

class UserSetting extends ChangeNotifier {
  late SharedPreferences prefs;

  final List<Locale> supportedLocales = S.delegate.supportedLocales;

  static const String IS_FIRST_LAUNCH_KEY = "is_first_launch";
  static const String LANGUAGE_NUM_KEY = "language_num";
  static const String USE_DYNAMIC_COLOR_KEY = "use_dynamic_color";
  static const String COLOR_SEED_KEY = "color_seed";
  static const String IS_DARK_MODE_KEY = "is_dark_mode";
  static const String API_SERVER_KEY = "api_server";
  static const String API_LANGUAGE_KEY = "api_language";
  static const String ALTERNATIVE_SOURCE_KEY = "alternative_source";
  static const String ALTERNATIVE_SOURCE_NUM_KEY = "alternative_source_num";

  bool firstLaunch = true;
  int languageNum = -1;
  bool dynamicColor = true;
  Color colorSeed = const Color(0xff6750a4);
  int darkMode = -1;
  int apiServer = 0;
  int apiLanguage = 0;
  bool alternativeSource = true;
  int alternativeSourceNum = 0;
  dynamic locale = const Locale('en', 'US');

  // Use singleton pattern
  UserSetting._privateConstructor();
  static final UserSetting _instance = UserSetting._privateConstructor();
  factory UserSetting() {
    return _instance;
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    setFirstLaunch(prefs.getBool(IS_FIRST_LAUNCH_KEY) ?? true);
    setLanguageNum(prefs.getInt(LANGUAGE_NUM_KEY) ?? -1);
    setDynamicColor(prefs.getBool(USE_DYNAMIC_COLOR_KEY) ?? true);
    setColorSeed(Color(prefs.getInt(COLOR_SEED_KEY) ?? 0xff6750a4));
    setDarkMode(prefs.getInt(IS_DARK_MODE_KEY) ?? -1);
    setApiServer(prefs.getInt(API_SERVER_KEY) ?? 0);
    setApiLanguage(prefs.getInt(API_LANGUAGE_KEY) ?? 0);
    setAlternativeSource(prefs.getBool(ALTERNATIVE_SOURCE_KEY) ?? true);
    setAlternativeSourceNum(prefs.getInt(ALTERNATIVE_SOURCE_NUM_KEY) ?? 0);
  }

  Future<void> setFirstLaunch(bool target) async {
    firstLaunch = target;
    await prefs.setBool(IS_FIRST_LAUNCH_KEY, target);
    notifyListeners();
  }

  Future<void> setLanguageNum(int target) async {
    languageNum = target;
    await prefs.setInt(LANGUAGE_NUM_KEY, target);
    if (languageNum == -1) {
      locale = null;
    } else if (languageNum >= 0 && languageNum < supportedLocales.length) {
      locale = supportedLocales[languageNum];
      await S.load(locale!);
    }
    notifyListeners();
  }

  Future<void> setDynamicColor(bool target) async {
    dynamicColor = target;
    await prefs.setBool(USE_DYNAMIC_COLOR_KEY, target);
    notifyListeners();
  }

  Future<void> setColorSeed(Color target) async {
    colorSeed = target;
    await prefs.setInt(COLOR_SEED_KEY, target.value);
    notifyListeners();
  }

  Future<void> setDarkMode(int target) async {
    darkMode = target;
    await prefs.setInt(IS_DARK_MODE_KEY, target);
    notifyListeners();
  }

  Future<void> setApiServer(int target) async {
    apiServer = target;
    await prefs.setInt(API_SERVER_KEY, target);
    notifyListeners();
  }

  Future<void> setApiLanguage(int target) async {
    apiLanguage = target;
    await prefs.setInt(API_LANGUAGE_KEY, target);
    notifyListeners();
  }

  Future<void> setAlternativeSource(bool target) async {
    alternativeSource = target;
    await prefs.setBool(ALTERNATIVE_SOURCE_KEY, target);
    notifyListeners();
  }

  Future<void> setAlternativeSourceNum(int target) async {
    alternativeSourceNum = target;
    await prefs.setInt(ALTERNATIVE_SOURCE_NUM_KEY, target);
    notifyListeners();
  }

  bool get getFirstLaunch => firstLaunch;
  int get getLanguageNum => languageNum;
  bool get getDynamicColor => dynamicColor;
  Color get getColorSeed => colorSeed;
  int get getDarkMode => darkMode;
  int get getApiServer => apiServer;
  int get getApiLanguage => apiLanguage;
  bool get getAlternativeSource => alternativeSource;
  int get getAlternativeSourceNum => alternativeSourceNum;
}
