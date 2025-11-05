import 'package:flutter/material.dart';

// Correct imports for the screen files
import 'package:medtrack_app/screens/welcome_screen.dart';
import 'screens/pill reminder screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

// This file defines the constant strings for routing names and the
// map of routes used by the MaterialApp in main.dart.

class AppRoutes {
  // --- Route Name Constants (Fixed: No Duplicates) ---
  static const String welcome = '/'; // Must be defined as the root route
  static const String signup = '/signup';
  static const String login = '/login';
  static const String pillReminder =
      '/pill_reminder'; // Authenticated User Home
  static const String guestMode = '/guest_pill_reminder'; // Guest User Home

  // --- Centralized Route Map (Fixed: No Duplicate Keys) ---
  static Map<String, WidgetBuilder> get routes => {
    // Mapping the route names to the actual screen widgets
    welcome: (context) =>
        const WelcomeScreen(), // Must map to the WelcomeScreen
    signup: (context) => const SignupScreen(),
    login: (context) => const LoginScreen(),

    // Authenticated access to Pill Reminder Screen
    pillReminder: (context) => const PillReminderScreen(isGuest: false),

    // Guest access to Pill Reminder Screen
    guestMode: (context) => const PillReminderScreen(isGuest: true),
  };
}
