import 'package:flutter/material.dart';
import 'dart:async'; // Required for Timer

// Feature 5: Anti-Procrastination Timer Screen
// Simulates timer functionality and motivation.
class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // Timer State
  Duration _duration = const Duration(minutes: 30);
  Timer? _timer;
  bool _isRunning = false;

  // Saved Timer State
  final Map<String, Duration> _savedTimers = {
    'Default Focus': const Duration(minutes: 30),
    'Deep Work': const Duration(minutes: 60),
    'Quick Task': const Duration(minutes: 15),
  };

  // Motivational Quotes
  final List<String> _quotes = [
    "The way to get started is to quit talking and begin doing. - Walt Disney",
    "Productivity is never an accident. It is always the result of a commitment to excellence.",
    "Do the hardest thing first. You can always celebrate later.",
    "Procrastination is the thief of time.",
    "A journey of a thousand miles begins with a single step.",
  ];

  String _currentQuote = "Ready to focus? Tap Start!";

  @override
  void initState() {
    super.initState();
    _currentQuote = _quotes[0];
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // --- Timer Controls ---

  void _startTimer() {
    if (_isRunning || _duration.inSeconds <= 0) return;

    _currentQuote = _quotes[(_duration.inMinutes % _quotes.length).toInt()];

    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 0) {
        _stopTimer(alarm: true);
        return;
      }
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      });
    });
    setState(() {});
  }

  void _pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
    setState(() {});
  }

  void _resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    _duration = _savedTimers.values.first; // Reset to the first saved duration
    setState(() {
      _currentQuote = "Ready to focus? Tap Start!";
    });
  }

  void _stopTimer({bool alarm = false}) {
    _timer?.cancel();
    _isRunning = false;

    if (alarm) {
      // Simulate Alarm/Notification functionality
      _showAlarmNotification(context);
    }
    setState(() {});
  }

  void _snoozeTimer() {
    // Snooze for 10 minutes
    _duration = const Duration(minutes: 10);
    _startTimer();
  }

  // --- Utility Methods ---

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = (d.inHours).toString();
    String minutes = twoDigits(d.inMinutes.remainder(60));
    String seconds = twoDigits(d.inSeconds.remainder(60));

    if (d.inHours > 0) {
      return "$hours:$minutes:$seconds";
    }
    return "$minutes:$seconds";
  }

  void _showAlarmNotification(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('🎉 Time\'s Up!'),
          content: const Text('Your focus session is complete!'),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Snooze (10 min)',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _snoozeTimer();
              },
            ),
            TextButton(
              child: const Text(
                'Complete',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _resetTimer();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Session completed and timer reset!'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // --- Settings and Customization ---

  Future<void> _customizeTimer() async {
    final newDuration = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: _duration.inHours,
        minute: _duration.inMinutes.remainder(60),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (newDuration != null) {
      final hours = newDuration.hour;
      final minutes = newDuration.minute;
      final totalMinutes = (hours * 60) + minutes;

      if (totalMinutes > 0) {
        setState(() {
          _duration = Duration(minutes: totalMinutes);
          _pauseTimer();
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Timer must be set to a duration greater than zero.',
              ),
            ),
          );
        }
      }
    }
  }

  Future<void> _saveTimer() async {
    final TextEditingController nameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Timer Preset'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Preset Name (e.g., Study Session)",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    _savedTimers[nameController.text] = _duration;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Preset "${nameController.text}" saved!'),
                    ),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // --- Build Method ---

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isTimerZero = _duration.inSeconds == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Timer'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _customizeTimer,
            tooltip: 'Customize Time',
          ),
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _saveTimer,
            tooltip: 'Save Preset',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // --- Motivational Character and Quote ---
            _buildMotivationalSection(primaryColor),

            const SizedBox(height: 30),

            // --- Timer Display ---
            Text(
              _formatDuration(_duration),
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w100,
                color: primaryColor,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),

            const SizedBox(height: 30),

            // --- Control Buttons ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildControlButton(
                  icon: Icons.refresh,
                  label: 'Reset',
                  color: Colors.grey,
                  onPressed: _resetTimer,
                ),
                const SizedBox(width: 20),

                // Play/Pause Button
                _buildControlButton(
                  icon: _isRunning
                      ? Icons.pause_circle_filled
                      : (isTimerZero
                            ? Icons.replay_circle_filled
                            : Icons.play_circle_filled),
                  label: _isRunning
                      ? 'Pause'
                      : (isTimerZero ? 'Restart' : 'Start'),
                  color: primaryColor,
                  size: 80,
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                ),
                const SizedBox(width: 20),

                // Add 1 Minute Button (Delay option)
                _buildControlButton(
                  icon: Icons.add_alarm,
                  label: '+1 Min',
                  color: Colors.green,
                  onPressed: () {
                    if (_isRunning) {
                      setState(() {
                        _duration = Duration(seconds: _duration.inSeconds + 60);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('+1 minute added to timer!'),
                          ),
                        );
                      });
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // --- Saved Presets Section ---
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Saved Timers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildSavedPresets(primaryColor),
          ],
        ),
      ),
    );
  }

  // --- Widgets ---

  Widget _buildMotivationalSection(Color primaryColor) {
    return Column(
      children: [
        // Motivational Character (Placeholder using an icon)
        Icon(
          Icons.self_improvement,
          size: 70,
          color: primaryColor.withOpacity(0.8),
        ),
        const SizedBox(height: 10),

        // Motivational Quote Bubble
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: primaryColor, width: 1.5),
          ),
          child: Text(
            _currentQuote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: primaryColor.computeLuminance() > 0.5
                  ? Colors.black87
                  : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
    double size = 60,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: size, color: color),
          onPressed: onPressed,
          tooltip: label,
        ),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSavedPresets(Color primaryColor) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: _savedTimers.entries.map((entry) {
        return InputChip(
          label: Text('${entry.key} (${entry.value.inMinutes} min)'),
          backgroundColor: primaryColor.withOpacity(0.1),
          side: BorderSide(color: primaryColor.withOpacity(0.5)),
          onPressed: () {
            _pauseTimer();
            setState(() {
              _duration = entry.value;
              _currentQuote = "Preset loaded: ${entry.key}";
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${entry.key} preset loaded.')),
            );
          },
          deleteIcon: const Icon(Icons.close, size: 18),
          onDeleted: entry.key != 'Default Focus'
              ? () {
                  setState(() {
                    _savedTimers.remove(entry.key);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preset "${entry.key}" deleted.')),
                  );
                }
              : null, // Prevent deleting the default timer
        );
      }).toList(),
    );
  }
}
