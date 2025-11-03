import 'package:flutter/material.dart';
import 'package:medtrack_app/screens/login_screen.dart';
import 'package:medtrack_app/screens/welcome_screen.dart';

// This file defines the constant strings for routing names and the
// map of routes used by the MaterialApp in main.dart.

class AppRoutes {
  // --- Route Name Constants ---
  static const String welcome = '/welcome';
  static const String signup = '/signup';
  static const String login = '/login'; // Placeholder for Feature 2

  // --- Centralized Route Map ---
  // This map connects a route name (String) to the actual screen widget (WidgetBuilder).
  static Map<String, WidgetBuilder> get routes => {
    welcome: (context) => const WelcomeScreen(),
    signup: (context) => const SignupScreen(),
    // We will add the LoginScreen here when we build Feature 2
    // login: (context) => const LoginScreen(),
  };
}
