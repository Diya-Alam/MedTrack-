// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:medtrack_app/routes.dart';

// Feature 1: The Welcome Screen UI/UX.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Action for the 'Get Started' button
  void _onGetStartedPressed(BuildContext context) {
    // Navigate to the Signup Screen
    Navigator.of(context).pushNamed(AppRoutes.signup);
  }

  // Action for the Login button
  void _onLoginPressed(BuildContext context) {
    // Navigate to the Login Screen
    Navigator.of(context).pushNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: EdgeInsets.all(isMobile ? 24.0 : 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Image/Logo placeholder (use your asset path)
                // Image.asset(
                //   'assets/welcome_illustration.png',
                //   height: isMobile ? 200 : 300,
                // ),

                // Placeholder Icon
                Icon(
                  Icons.favorite_border,
                  size: isMobile ? 120 : 180,
                  color: primaryColor,
                ),
                const SizedBox(height: 40),

                // Main Title
                Text(
                  'Welcome to MediTrack+',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // Subtitle/Description
                const Text(
                  'Manage your medications and health schedule with ease and precision. Never miss a dose again!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),

                const SizedBox(height: 60),

                // Get Started Button
                ElevatedButton(
                  onPressed: () => _onGetStartedPressed(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Get Started (Sign Up)'),
                ),

                const SizedBox(height: 16),

                // Login Button
                OutlinedButton(
                  onPressed: () => _onLoginPressed(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    side: BorderSide(color: primaryColor, width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
