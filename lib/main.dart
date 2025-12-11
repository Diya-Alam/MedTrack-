// lib/main.dart (FINAL CLEAN CODE)

import 'package:flutter/material.dart'; // ✅ FIX: Use the full import to prevent naming conflicts
import 'package:provider/provider.dart';
import 'package:medtrack_app/routes.dart';

// Import the Settings Model
import 'models/settings_state_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsStateModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consume the settings state here to apply theme and font size changes
    return Consumer<SettingsStateModel>(
      builder: (context, settings, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MedTrack+',

          // Apply theme mode from settings
          themeMode: settings.themeMode,

          // Define Light Theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            // Apply font size scaling from the settings model
            // NOTE: Theme.of(context) must be inside the builder/Consumer
            textTheme: Theme.of(
              context,
            ).textTheme.apply(fontSizeFactor: settings.fontSizeScale),
          ),

          // Define Dark Theme
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.blue,
            // Apply font size scaling from the settings model
            textTheme: Theme.of(
              context,
            ).textTheme.apply(fontSizeFactor: settings.fontSizeScale),
          ),

          initialRoute: AppRoutes.welcome,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
