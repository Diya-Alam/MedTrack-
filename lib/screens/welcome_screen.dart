// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:medtrack_app/routes.dart';

// Feature 1: The Welcome Screen UI/UX.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Action for the 'Get Started' button
  void _onGetStartedPressed(BuildContext context) {
    // Navigate directly to the Pill Reminder Screen in Guest Mode,
    // using pushReplacementNamed to prevent going back to Welcome.
    Navigator.of(context).pushReplacementNamed(AppRoutes.guestMode);
  }

  // Action for the 'Sign Up' button
  void _onSignupPressed(BuildContext context) {
    // Navigate to the Signup Screen
    Navigator.of(context).pushNamed(AppRoutes.signup);
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
                // 1. Image of the heart-shaped path
                Image.asset(
                  'assets/welcome_illustration.png', // <-- Updated to use the image asset
                  height: isMobile ? 200 : 300,
                  // If the image fails to load, it will show nothing or a tiny error icon.
                ),

                // REMOVE THE PLACEHOLDER ICON: Icon(Icons.favorite_border, ...)
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
                const Text(
                  'Manage your medications and health schedule with ease and precision. Never miss a dose again!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),

                const SizedBox(height: 60),

                // 2. Get Started Button (Now leads to Guest Mode)
                ElevatedButton(
                  onPressed: () =>
                      _onGetStartedPressed(context), // <-- New action
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
                  child: const Text(
                    'Get Started (Skip Login)',
                  ), // <-- Updated label
                ),

                const SizedBox(height: 16),

                // 3. Sign Up Button (Replaces old Login Button)
                OutlinedButton(
                  onPressed: () => _onSignupPressed(context), // <-- New action
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
                  child: const Text(
                    'Create an Account (Sign Up)',
                  ), // <-- New label
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
