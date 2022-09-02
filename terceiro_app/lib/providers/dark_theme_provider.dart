import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terceiro_app/utils/dark_theme_preference.dart';

const themeStatus = "THEMESTATUS";

class DarkThemeProvider extends ChangeNotifier {
  late ThemeMode theme;

  bool get isDarkMode => theme == ThemeMode.dark;

  DarkThemeProvider({bool? isDark}) {
    isDark = isDark ?? false;
    theme = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> alterarTema() async {
    // theme = isDark ? ThemeMode.dark : ThemeMode.light;
    // darkThemePreference.setDarkTheme(isDark);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, isDarkMode);
    notifyListeners();
  }

  ThemeMode get getTheme => theme;
}
