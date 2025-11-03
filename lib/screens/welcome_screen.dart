import 'package:flutter/material.dart';
import '../routes.dart';

// Feature 1: The Welcome Screen UI/UX.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Action for the 'Get Started' button
  void _onGetStartedPressed(BuildContext context) {
    // Navigates to the signup route
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  // Placeholder for the Login button logic (required by your README)
  void _onLoginPressed(BuildContext context) {
    // This will be updated to navigate to AppRoutes.login once the LoginScreen is implemented
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login screen not implemented yet.')),
    );
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
                // --- Image Asset Placeholder ---
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: isMobile ? 250 : 350,
                    child: Image.asset(
                      'assets/welcome_illustration.png', // <--- Your specified asset path
                      fit: BoxFit
                          .contain, // Ensures the image fits within the box
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback placeholder if the image path is incorrect or file is missing
                        return Container(
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported_outlined,
                                size: 50,
                                color: primaryColor,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Illustration Not Found (Check assets/welcome_illustration.png)',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: isMobile ? 40 : 60),

                // --- Motivational Tagline ---
                Text(
                  'Your Health, Our Priority.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 16),

                // Sub-tagline
                const Text(
                  'Never miss a dose. Stay organized, informed, and on track with MediTrack+.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),

                SizedBox(height: isMobile ? 50 : 80),

                // --- Get Started Button (Navigates to Sign Up) ---
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
                  child: const Text('Get Started'),
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
