// lib/widgets/main_app_shell.dart (MODIFIED)

import 'package:flutter/material.dart';

// Import the core feature screens
import '../screens/health_monitor_screen.dart';
import 'package:medtrack_app/screens/pill_reminder_screen.dart';
import 'package:medtrack_app/screens/timer_screen.dart';
import 'package:medtrack_app/screens/scheduling_screen.dart';
// 1. NEW IMPORT: Settings Screen
import '../screens/settings_screen.dart';

class MainAppShell extends StatefulWidget {
  final bool isGuest;

  const MainAppShell({super.key, required this.isGuest});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  // Now 5 indices: 0, 1, 2, 3, 4
  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // 2. ADD SettingsScreen to the list of major screens
    _widgetOptions = <Widget>[
      PillReminderScreen(isGuest: widget.isGuest), // Index 0: Reminders
      const HealthMonitorScreen(), // Index 1: Monitor
      const TimerScreen(), // Index 2: Focus Timer
      const SchedulingScreen(), // Index 3: Care/Sched
      const SettingsScreen(), // Index 4: Settings (NEW)
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
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: 'Monitor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            label: 'Focus Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Care/Sched',
          ),
          // 3. NEW NAVIGATION ITEM: Settings
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        // Customize appearance
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        // Ensure all labels are visible for 5 items
        type: BottomNavigationBarType.fixed,
        // Handle tab selection
        onTap: _onItemTapped,
      ),
    );
  }
}
