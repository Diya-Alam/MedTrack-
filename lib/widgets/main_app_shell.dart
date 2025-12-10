// lib/widgets/main_app_shell.dart

import 'package:flutter/material.dart';

// Import the core feature screens
import '../screens/health_monitor_screen.dart';
import 'package:medtrack_app/screens/pill_reminder_screen.dart';
import 'package:medtrack_app/screens/timer_screen.dart';
// Feature 7: The Complex Scheduling Screen
import 'package:medtrack_app/screens/scheduling_screen.dart';
// NEW: Feature 6 (Reports)
import 'package:medtrack_app/screens/medication_report_screen.dart';

class MainAppShell extends StatefulWidget {
  // isGuest determines the behavior of screens like PillReminderScreen
  final bool isGuest;

  const MainAppShell({super.key, required this.isGuest});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  // Current selected tab index (0, 1, 2, 3, or 4) - NOW 5 total screens
  int _selectedIndex = 0;

  // List of screens available in the Bottom Navigation Bar (5 total)
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // Screen List: These are the top-level views managed by the shell.
    _widgetOptions = <Widget>[
      PillReminderScreen(
        isGuest: widget.isGuest,
      ), // Index 0: Reminders (Feature 3)
      MedicationReportScreen(
        isGuest: widget.isGuest,
      ), // NEW: Index 1: Reports (Feature 6)
      const HealthMonitorScreen(), // Index 2: Monitor (Feature 4) - shifted
      const TimerScreen(), // Index 3: Focus Timer (Feature 5) - shifted
      const SchedulingScreen(), // Index 4: Complex Scheduling (Feature 7) - shifted
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the screen corresponding to the selected index
      body: _widgetOptions.elementAt(_selectedIndex),

      // Bottom Navigation Bar with 5 items
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled),
            label: 'Reminders',
          ),
          // NEW ITEM: Reports (Index 1)
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: 'Monitor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            label: 'Focus Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt), // Icon for Dependent/Care
            label: 'Care/Sched', // Label for Complex Scheduling
          ),
        ],
        currentIndex: _selectedIndex,
        // Customize appearance
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        // Handle tab selection
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensure 5 items fit
      ),
    );
  }
}
