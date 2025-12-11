// lib/models/settings_state_model.dart

import 'package:flutter/material.dart';

class SettingsStateModel extends ChangeNotifier {
  // ------------------------------------
  // Appearance Settings (Feature 2)
  // ------------------------------------
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Color _backgroundColor = Colors.white;
  Color get backgroundColor => _backgroundColor;

  double _fontSizeScale = 1.0;
  double get fontSizeScale => _fontSizeScale;

  // ------------------------------------
  // Date & Time Settings (Feature 3)
  // ------------------------------------
  bool _is24HourFormat = true;
  bool get is24HourFormat => _is24HourFormat;

  int _startDayOfWeek = DateTime.monday; // 1 for Monday, 7 for Sunday
  int get startDayOfWeek => _startDayOfWeek;

  // ------------------------------------
  // Sound & Notifications Settings (Feature 4)
  // ------------------------------------
  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  bool _vibrationEnabled = true;
  bool get vibrationEnabled => _vibrationEnabled;

  // --- SETTERS (Functions that update the state) ---

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  void setFontSizeScale(double scale) {
    _fontSizeScale = scale;
    notifyListeners();
  }

  void toggleTimeFormat() {
    _is24HourFormat = !_is24HourFormat;
    notifyListeners();
  }

  void setStartDayOfWeek(int day) {
    _startDayOfWeek = day;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void toggleVibration(bool value) {
    _vibrationEnabled = value;
    notifyListeners();
  }
}
