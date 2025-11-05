import 'package:flutter/material.dart';

class PillReminderScreen extends StatelessWidget {
  const PillReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define colors based on theme, falling back if not set
    final Color primaryBlue = Theme.of(context).primaryColor;
    final Color lightBlueBackground = primaryBlue.withOpacity(0.05);

    return Scaffold(
      backgroundColor: lightBlueBackground, // Overall light blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () {
            // TODO: Implement navigation back
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black87),
            onPressed: () {
              // TODO: Implement settings action
            },
          ),
        ],
      ),
      body: SafeArea(
        // Ensures content is not obscured by system UI
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // --- Page Title ---
                const Text(
                  'Pill Reminder',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),

                // --- Pill Icon Circle ---
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(
                      0.2,
                    ), // Light blue circle background
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.medical_services, // Pill icon
                      size: 80,
                      color: primaryBlue, // Blue pill icon
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // --- Medication Details Card ---
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Wrap content height
                      children: <Widget>[
                        const Text(
                          '7:00 AM', // Time
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Medication', // Medication Name
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '1 Tablet (500mg)', // Dose
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Inner pill icon
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.medical_services,
                            color: primaryBlue,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // --- "Take Now" Button ---
                        SizedBox(
                          width: double.infinity, // Max width
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implement "Take Now" action
                            },
                            icon: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ), // Arrow icon
                            label: const Text(
                              'Take Now',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- Skipped and Reschedule Buttons ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Implement "Skipped" action
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Skipped',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Implement "Reschedule" action
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Reschedule',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
