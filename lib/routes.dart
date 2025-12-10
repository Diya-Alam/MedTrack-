// lib/routes.dart

import 'package:flutter/material.dart';

// Import all necessary screens and the shell widget
import 'package:medtrack_app/screens/welcome_screen.dart';
import 'package:medtrack_app/widgets/main_app_shell.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/health_monitor_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/scheduling_screen.dart'; // Keep the new screen
import 'package:medtrack_app/screens/pill_reminder_screen.dart'; // NEW IMPORT for standalone access

class AppRoutes {
  // --- Route Name Constants ---
  static const String welcome = '/';
  static const String signup = '/signup';
  static const String login = '/login';

  // These routes now point to the MainAppShell wrapper
  static const String pillReminder =
      '/pill_reminder'; // Authenticated User Home
  static const String guestMode = '/guest_pill_reminder'; // Guest User Home

  static const String healthMonitor = '/health_monitor';
  static const String focusTimer = '/focus_timer';
  // Feature 6 (Reports) route constant is now permanently removed.
  static const String scheduling = '/scheduling';

  // --- Centralized Route Map ---
  static Map<String, WidgetBuilder> get routes => {
    // Mapping the route names to the actual screen widgets
    welcome: (context) => const WelcomeScreen(),
    signup: (context) => const SignupScreen(),
    login: (context) => const LoginScreen(),

    // Direct Screen Mappings (for testing/deep links)
    healthMonitor: (context) => const HealthMonitorScreen(),
    focusTimer: (context) => const TimerScreen(),
    // Feature 6 (Reports) route mapping is now permanently removed.
    scheduling: (context) => const SchedulingScreen(),

    // Main Shell Wrappers (Home)
    pillReminder: (context) => const MainAppShell(isGuest: false),
    // CHANGE: Guest Mode now goes directly to PillReminderScreen without the Shell
    guestMode: (context) => const PillReminderScreen(isGuest: true),
  };
}
