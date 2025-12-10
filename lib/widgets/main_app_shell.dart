import 'package:flutter/material.dart';

// Import the core feature screens
import '../screens/health_monitor_screen.dart';
import 'package:medtrack_app/screens/pill_reminder_screen.dart';
import 'package:medtrack_app/screens/timer_screen.dart';

class MainAppShell extends StatefulWidget {
  final bool isGuest;

  const MainAppShell({super.key, required this.isGuest});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // WIDGET OPTIONS: Now only contains the three active screens
    _widgetOptions = <Widget>[
      PillReminderScreen(isGuest: widget.isGuest), // Index 0: Reminders
      const HealthMonitorScreen(), // Index 1: Monitor
      const TimerScreen(), // Index 2: Focus Timer
    ];
  }

  void _onItemTapped(int index) {
    // We only have indices 0, 1, 2 now
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),

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
          // FOCUS TIMER is now the final item (Index 2)
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            label: 'Focus Timer',
          ),
          // *** REPORTS ITEM HAS BEEN REMOVED ***
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
