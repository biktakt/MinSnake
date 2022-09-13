import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _SharedPreferencesKeys {
  static const darkTheme = 'darkTheme';
}

class SettingsWidgetModel extends ChangeNotifier {
  final _storage = SharedPreferences.getInstance();
  ThemeMode _currentTheme = ThemeMode.dark;

  ThemeMode get currentTheme => _currentTheme;

  SettingsWidgetModel() {
    setup();
  }

  void setup() async {
    _currentTheme = await _readTheme();
    notifyListeners();
  }

  void toggleTheme() {
    _currentTheme =
        _currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _setTheme(_currentTheme == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> _setTheme(bool isDarkMode) async {
    (await _storage).setBool(_SharedPreferencesKeys.darkTheme, isDarkMode);
  }

  Future<ThemeMode> _readTheme() async {
    final isDarkMode =
        (await _storage).getBool(_SharedPreferencesKeys.darkTheme) ?? true;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}
