import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  late SharedPreferences _prefs;

  LanguageProvider() {
    _initPrefs();
  }

  Locale get currentLocale => _currentLocale;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await loadSavedLanguage();
  }

  Future<void> loadSavedLanguage() async {
    final savedLanguage = _prefs.getString('language') ?? 'en';
    _currentLocale = Locale(savedLanguage);
    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    await _prefs.setString('language', languageCode);
    notifyListeners();
  }
}
