import 'package:flutter/material.dart';

// Import the core feature screens
import '../screens/health_monitor_screen.dart';
import 'package:medtrack_app/screens/pill_reminder_screen.dart';
import 'package:medtrack_app/screens/timer_screen.dart';
// Feature 7: The Complex Scheduling Screen
import 'package:medtrack_app/screens/scheduling_screen.dart';

class MainAppShell extends StatefulWidget {
  // isGuest determines the behavior of screens like PillReminderScreen
  final bool isGuest;

  const MainAppShell({super.key, required this.isGuest});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  // Current selected tab index (0, 1, 2, or 3)
  int _selectedIndex = 0;

  // List of screens available in the Bottom Navigation Bar (4 total)
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // Screen List: These are the top-level views managed by the shell.
    _widgetOptions = <Widget>[
      PillReminderScreen(
        isGuest: widget.isGuest,
      ), // Index 0: Reminders (Feature 3)
      const HealthMonitorScreen(), // Index 1: Monitor (Feature 4)
      const TimerScreen(), // Index 2: Focus Timer (Feature 5)
      const SchedulingScreen(), // Index 3: Complex Scheduling (Feature 7)
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

      // Bottom Navigation Bar with 4 items
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
      ),
    );
  }
}
