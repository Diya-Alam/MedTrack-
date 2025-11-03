import 'package:flutter/material.dart';

// AppRoutes is defined here so the app can compile even if an external app_routes.dart
// file is not present; you can remove this class if you provide a separate app_routes.dart.
class AppRoutes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
  };
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 1. Set the initial route using the constant from AppRoutes
      initialRoute: AppRoutes.welcome,
      // 2. Link the external routes map
      routes: AppRoutes.routes,
    );
  }
}

// NOTE: You must also define your screen widgets (WelcomeScreen, LoginScreen, SignupScreen)
// in separate files and ensure they are properly imported in app_routes.dart.

// The provided screens are kept here for completeness, but should generally be
// in their own files (e.g., welcome_screen.dart, login_screen.dart).

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Login Screen')));
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Welcome Screen')));
  }
}

// You will also need the SignupScreen which is referenced in AppRoutes
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Signup Screen')));
  }
}
