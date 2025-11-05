import 'package:flutter/material.dart'
    show
        BuildContext,
        MaterialApp,
        StatelessWidget,
        Widget,
        runApp,
        ThemeData,
        Colors;
// Importing the AppRoutes definition
import 'package:medtrack_app/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedTrack+',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Set the initial route to the Pill Reminder screen for immediate testing
      initialRoute: AppRoutes.pillReminder,
      // Link the external routes map
      routes: AppRoutes.routes,
    );
  }
}

// NOTE: The screen definitions (WelcomeScreen, LoginScreen, SignupScreen) are
// now expected to be in their own files and imported via routes.dart.
