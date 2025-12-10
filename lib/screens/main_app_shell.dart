import 'package:flutter/material.dart';

// Import the core feature screens
import '../screens/health_monitor_screen.dart';
import 'package:medtrack_app/screens/pill_reminder_screen.dart';
// 1. ADD IMPORT: Import the Timer Screen
import 'package:medtrack_app/screens/timer_screen.dart';

class MainAppShell extends StatefulWidget {
  final bool isGuest;

  // The isGuest status is passed down from the route call
  const MainAppShell({super.key, required this.isGuest});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _selectedIndex =
      0; // Current selected tab index (0 = Pill Reminder, 1 = Health Monitor)

  // List of screens available in the Bottom Navigation Bar
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // 2. UPDATE SCREEN LIST: Replace the placeholder with the actual TimerScreen
    _widgetOptions = <Widget>[
      PillReminderScreen(isGuest: widget.isGuest), // Index 0: Reminders
      const HealthMonitorScreen(), // Index 1: Monitor
      const TimerScreen(), // Index 2: Focus Timer
      // The 'Reports' placeholder screen has been removed entirely.
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

      // Bottom Navigation Bar
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
          // 3. UPDATE NAV ITEM: Change the 'Reports' tab to 'Focus Timer'
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined), // Timer Icon
            label: 'Focus Timer', // Correct Label
          ),
          // The 'Reports' navigation item has been removed entirely.
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
