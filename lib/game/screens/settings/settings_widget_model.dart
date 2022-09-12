import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _SharedPreferencesKeys {
  static const depecheMode = 'depecheMode';
  static const darkTheme = 'darkTheme';
}

class SettingsWidgetModel extends ChangeNotifier {
  final _storage = SharedPreferences.getInstance();
  ThemeMode _currentTheme = ThemeMode.dark;
  bool _depecheMode = false;

  ThemeMode get currentTheme => _currentTheme;
  bool get depecheMode => _depecheMode;

  SettingsWidgetModel() {
    setup();
  }

  void setup() async {
    _currentTheme = await _readTheme();
    _depecheMode = await _readDepecheMode();
    notifyListeners();
  }

  void toggleTheme() {
    _currentTheme =
        _currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _setTheme(_currentTheme == ThemeMode.dark);
    notifyListeners();
  }

  void toggleDepecheMode() {
    _depecheMode = !_depecheMode;
    _setDepecheMode(_depecheMode);
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

  Future<void> _setDepecheMode(bool depecheMode) async {
    (await _storage).setBool(_SharedPreferencesKeys.depecheMode, depecheMode);
  }

  Future<bool> _readDepecheMode() async {
    return (await _storage).getBool(_SharedPreferencesKeys.depecheMode) ??
        false;
  }
}
