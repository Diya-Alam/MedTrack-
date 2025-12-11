// lib/screens/settings_screen.dart (MODIFIED)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/settings_state_model.dart';
// Import the new sub-screens
import 'settings_detail_screens.dart';
import 'package:medtrack_app/routes.dart';

// --- Reusable Widget for a Setting Category Header ---
class _SettingGroupHeader extends StatelessWidget {
  final String title;
  const _SettingGroupHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0, left: 16.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// --- MAIN SCREEN WIDGET ---

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Helper to build Placeholder Screen routes
  void _navigateToPlaceholder(
    BuildContext context,
    String title,
    List<String> features,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            PlaceholderScreen(title: title, features: features),
      ),
    );
  }

  // Placeholder for User Profile details
  Widget _buildUserProfileTile(BuildContext context) {
    // NOTE: Using static mock data for display. In a real app, this would come from a user state model.
    const mockUsername = 'Alexander M.';
    const mockEmail = 'alex.m@medtrack.com';

    // Feature 1: User Profile
    return ListTile(
      leading: const CircleAvatar(
        radius: 28,
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.person, color: Colors.white, size: 30),
      ),
      title: const Text(
        mockUsername,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(mockEmail),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => _navigateToPlaceholder(context, 'User Profile', [
        'Edit account details: Change username, email, or password',
        'Manage linked accounts: Connect/disconnect social logins (Google)',
        'Privacy controls: Manage visibility, data sharing, and permissions',
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the background color from the model
    final backgroundColor = Provider.of<SettingsStateModel>(
      context,
    ).backgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: <Widget>[
          // ===================================
          // I. ACCOUNT & PRIVACY (Feature 1)
          // ===================================
          const _SettingGroupHeader(title: 'Account & Privacy'),
          _buildUserProfileTile(context),

          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Security'),
            subtitle: const Text('Session management and login history'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _navigateToPlaceholder(context, 'Security', [
              'Session management',
              'Login history',
            ]),
          ),

          // ===================================
          // II. APP EXPERIENCE (Features 2, Accessibility, Language)
          // ===================================
          const _SettingGroupHeader(title: 'App Experience'),

          // Appearance (Functional Navigation)
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Appearance'),
            subtitle: const Text('Theme mode, color, font style'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AppearanceScreen()),
            ),
          ),

          // Accessibility (Placeholder Navigation)
          ListTile(
            leading: const Icon(Icons.accessibility_new),
            title: const Text('Accessibility'),
            subtitle: const Text('Screen reader, high contrast, shortcuts'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _navigateToPlaceholder(context, 'Accessibility', [
              'Screen reader support',
              'High contrast mode',
              'Keyboard shortcuts',
            ]),
          ),

          // Language & Region (Placeholder Navigation)
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language & Region'),
            subtitle: const Text('App language, number/date formats'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _navigateToPlaceholder(context, 'Language & Region', [
              'Change app language',
              'Number/date formats',
              'Currency display',
            ]),
          ),

          // ===================================
          // III. DATA & SYNC (Features 3, Backup/Sync)
          // ===================================
          const _SettingGroupHeader(title: 'Data & Sync'),

          // Date & Time (Functional Navigation)
          ListTile(
            leading: const Icon(Icons.schedule_outlined),
            title: const Text('Date & Time'),
            subtitle: const Text('Time format, start day of week, time zone'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DateTimeScreen()),
            ),
          ),

          // Backup & Sync (Placeholder Navigation)
          ListTile(
            leading: const Icon(Icons.cloud_sync_outlined),
            title: const Text('Backup & Sync'),
            subtitle: const Text('Local storage sync, export/import settings'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _navigateToPlaceholder(context, 'Backup & Sync', [
              'Local storage sync for preferences',
              'Export/Import settings',
            ]),
          ),

          // ===================================
          // IV. COMMUNICATION (Features 4, Help)
          // ===================================
          const _SettingGroupHeader(title: 'Communication'),

          // Sound & Notifications (Placeholder Navigation, but could be easily functional)
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: const Text('Sound & Notifications'),
            subtitle: const Text('Ringtone, vibration, Do Not Disturb'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () =>
                _navigateToPlaceholder(context, 'Sound & Notifications', [
                  'Ringtone for alarms',
                  'Vibration settings (On/Off or intensity)',
                  'Notification preferences (push, email, in-app)',
                  'Do Not Disturb mode',
                ]),
          ),

          // Help & Support (Placeholder Navigation)
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            subtitle: const Text('FAQs, contact support, and feedback'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _navigateToPlaceholder(context, 'Help & Support', [
              'FAQs',
              'Contact support',
              'Feedback submission',
            ]),
          ),

          // ===================================
          // V. EXIT (Feature 5)
          // ===================================
          const _SettingGroupHeader(title: 'Session'),

          // Sign Out (Functional Action)
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Actual Sign Out Logic: Navigate back to the WelcomeScreen
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.welcome,
                (Route<dynamic> route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed out successfully.')),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
