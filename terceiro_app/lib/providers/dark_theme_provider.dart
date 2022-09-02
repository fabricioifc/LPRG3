import 'package:flutter/material.dart';
import 'package:terceiro_app/utils/dark_theme_preference.dart';

class DarkThemeProvider with ChangeNotifier {
  late bool _isDark;
  late DarkThemePreference _preferences;
  bool get isDark => _isDark;

  DarkThemeProvider() {
    _isDark = false;
    _preferences = DarkThemePreference();
    getPreferences();
  }

//Switching the themes
  void alterar(bool value) {
    _isDark = value;
    _preferences.setDarkTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
  // DarkThemePreference darkThemePreference = DarkThemePreference();
  // bool _darkTheme = false;

  // bool get darkTheme => _darkTheme;

  // set darkTheme(bool value) {
  //   print(value);
  //   _darkTheme = value;
  //   darkThemePreference.setDarkTheme(value);
  //   notifyListeners();
  // }
}
