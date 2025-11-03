import 'package:flutter/material.dart';
// Assuming these are the correct paths to your screen files
import 'package:medtrack_app/screens/login_screen.dart'
    as login_screen; // Ensure this file defines and exports LoginScreen
import 'package:medtrack_app/screens/welcome_screen.dart';
import 'package:medtrack_app/screens/signup_screen.dart'
    as signup_screen; // Must be imported

// This file defines the constant strings for routing names and the
// map of routes used by the MaterialApp in main.dart.

class AppRoutes {
  // --- Route Name Constants ---
  static const String welcome =
      '/'; // It's common to use '/' for the initial route
  static const String signup = '/signup';
  static const String login = '/login';

  // --- Centralized Route Map ---
  static Map<String, WidgetBuilder> get routes => {
    // Mapping the route names to the actual screen widgets
    welcome: (context) => const WelcomeScreen(),
    signup: (context) => const signup_screen.SignupScreen(),
    login: (context) =>
        const login_screen.LoginScreen(), // Make sure 'LoginScreen' is defined and exported in login_screen.dart
  };
}
