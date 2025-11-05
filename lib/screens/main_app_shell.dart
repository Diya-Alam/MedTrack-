import 'package:flutter/material.dart';

// Import the core feature screens (Note: using the file names established in our conversation)
import 'pill reminder screen.dart';
import 'health_monitor_screen.dart';
//import 'timer_screen.dart';

class MainAppShell extends StatefulWidget {
  final bool isGuest;

  // The isGuest status is passed down from the route call (login/welcome)
  const MainAppShell({super.key, required this.isGuest});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  // Current selected tab index: 0=Reminders, 1=Monitor, 2=Timer
  int _selectedIndex = 0;

  // List of screens available in the Bottom Navigation Bar
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // Initialize the list of screens once, passing the initial isGuest status
    _widgetOptions = <Widget>[
      // Tab 0: Pill Reminders
      PillReminderScreen(isGuest: widget.isGuest),
      // Tab 1: Health Monitor
      const HealthMonitorScreen(),
      // Tab 2: Anti-Procrastination Timer
      //const TimerScreen(),
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
      // Display the screen corresponding to the selected index using IndexedStack
      // IndexedStack keeps all three widgets alive (e.g., the timer will keep running)
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),

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
          // NEW ITEM: Timer
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        // Use fixed type so all three labels are clearly visible
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
