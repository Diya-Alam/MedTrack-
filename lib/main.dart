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

      // THIS MUST BE SET TO THE WELCOME ROUTE:
      initialRoute: AppRoutes.welcome,

      // Link the external routes map
      routes: AppRoutes.routes,
    );
  }
}
