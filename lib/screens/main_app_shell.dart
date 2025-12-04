import 'package:flutter/material.dart';
// Note: Changed the import to match the standard name 'reminder_screen.dart'
// used in previous steps. If your file is named 'pill_reminder_screen.dart',
// this will need manual correction on your end to 'ReminderScreen()'.
import 'package:medtrack_app/screens/pill_reminder_screen.dart';
import 'package:medtrack_app/screens/timer_screen.dart';

// This screen acts as the main hub post-login, featuring a Bottom Navigation Bar.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens to be displayed in the body of the Scaffold
  final List<Widget> _screens = [
    // 0. Reminder Screen (Feature 3) - FIX: Pass required parameter 'isGuest: false'
    const PillReminderScreen(isGuest: false),

    // 1. Placeholder for Health Monitor (Feature 4)
    const Center(
      child: Text('Health Monitor (Feature 4)', style: TextStyle(fontSize: 20)),
    ),

    // 2. Anti-Procrastination Timer (Feature 5)
    const TimerScreen(),

    // 3. Placeholder for Reports/Profile (Features 6 & 7)
    const Center(
      child: Text('Reports & Profile', style: TextStyle(fontSize: 20)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      // The body displays the selected screen from the list above
      body: _screens[_selectedIndex],

      // --- Bottom Navigation Bar Implementation ---
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_outlined),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart_outlined),
            label: 'Monitor',
          ),
          // Timer Icon
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            label: 'Focus Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'Reports',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Use fixed type for 4 items
      ),
    );
  }
}
