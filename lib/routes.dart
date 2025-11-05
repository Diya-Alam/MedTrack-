import 'package:flutter/material.dart';

// Correct imports for the screen files
import 'package:medtrack_app/screens/welcome_screen.dart';
// Update the import path below to the correct relative path if the file exists, for example:
import 'screens/Pill Reminder Screen.dart';
import 'screens/login_screen.dart';
// If the file does not exist, create login_screen.dart in the appropriate directory.
import 'screens/signup_screen.dart';

// This file defines the constant strings for routing names and the
// map of routes used by the MaterialApp in main.dart.

class AppRoutes {
  // --- Route Name Constants ---
  static const String welcome =
      '/'; // It's common to use '/' for the initial route
  static const String signup = '/signup';
  static const String login = '/login';
  static const String pillReminder = '/pill_reminder'; // Added new route name

  // --- Centralized Route Map ---
  static Map<String, WidgetBuilder> get routes => {
    // Mapping the route names to the actual screen widgets
    welcome: (context) => const WelcomeScreen(),
    signup: (context) => const SignupScreen(),
    login: (context) => const LoginScreen(),
    pillReminder: (context) =>
        const PillReminderScreen(), // Mapped to the actual screen class
  };
}
