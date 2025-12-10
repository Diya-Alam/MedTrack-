// lib/screens/pill_reminder_screen.dart

import 'package:flutter/material.dart';
import '../widgets/add_pill_reminder_modal.dart'; // NEW IMPORT

// --- Pill Reminder Data Model ---
class PillReminder {
  final String medicationName;
  final String schedule; // e.g., 'Daily', 'Weekly', 'Monthly', 'As Needed'
  final TimeOfDay time;
  final DateTime startDate;
  final int
  repeatDays; // e.g., 0 for daily, 7 for weekly (reserved for future use)
  final int durationDays; // Duration of the course in days

  PillReminder({
    required this.medicationName,
    required this.schedule,
    required this.time,
    required this.startDate,
    required this.repeatDays,
    required this.durationDays,
  });
}

// --- Pill Reminder Screen Widget ---
class PillReminderScreen extends StatefulWidget {
  final bool isGuest;

  const PillReminderScreen({super.key, required this.isGuest});

  @override
  State<PillReminderScreen> createState() => _PillReminderScreenState();
}

class _PillReminderScreenState extends State<PillReminderScreen> {
  // Use a unique key for the list view to handle state updates cleanly
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Use a List instead of final to allow adding/removing items
  List<PillReminder> _reminders = [];

  @override
  void initState() {
    super.initState();
    // Initialize with mock data if not a guest
    if (!widget.isGuest) {
      _reminders.addAll(_mockReminders);
    }
  }

  // --- Mock Data ---
  final List<PillReminder> _mockReminders = [
    PillReminder(
      medicationName: 'Daily Vitamin',
      schedule: 'Daily',
      time: const TimeOfDay(hour: 8, minute: 0),
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      repeatDays: 0,
      durationDays: 30,
    ),
    PillReminder(
      medicationName: 'Blood Pressure Med',
      schedule: 'Daily',
      time: const TimeOfDay(hour: 17, minute: 30),
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      repeatDays: 0,
      durationDays: 90,
    ),
    PillReminder(
      medicationName: 'Joint Pain Relief',
      schedule: 'As Needed',
      time: const TimeOfDay(hour: 12, minute: 0),
      startDate: DateTime.now(),
      repeatDays: 0,
      durationDays: 7,
    ),
  ];

  // --- Action Handlers ---
  void _markAsTaken(PillReminder reminder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${reminder.medicationName} marked as taken!')),
    );
    // In a real app, this would log the action and remove the item from the 'due' list.
  }

  void _skipReminder(PillReminder reminder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${reminder.medicationName} skipped.')),
    );
  }

  void _rescheduleReminder(PillReminder reminder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${reminder.medicationName} rescheduled.')),
    );
  }

  // NEW: Add a new reminder to the list
  void _addReminder(PillReminder newReminder) {
    setState(() {
      _reminders.insert(0, newReminder); // Add to the top
    });
    // In a real app, you would add to a database first.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${newReminder.medicationName} reminder added successfully!',
        ),
      ),
    );
  }

  // NEW: Function to display the Add Reminder Modal
  void _showAddReminderModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return AddPillReminderModal(onReminderAdded: _addReminder);
      },
    );
  }

  // --- Screen Builder ---

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    // Guest Mode UI Restriction Logic
    if (widget.isGuest) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pill Reminders (Guest View)'),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 60, color: Colors.grey),
                SizedBox(height: 20),
                Text(
                  'Access Limited',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Please sign up or log in to add new reminders, monitor health, or manage care schedules.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Authenticated User UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pill Reminders'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reminders Due Today',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 15),
            _reminders.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        'No reminders set. Tap the "+" to add one!',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = _reminders[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: PillReminderCard(
                          reminder: reminder,
                          onTaken: _markAsTaken,
                          onSkip: _skipReminder,
                          onReschedule: _rescheduleReminder,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      // NEW: Floating Action Button for adding new reminders
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddReminderModal(context),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// --- Pill Reminder Card Widget ---
class PillReminderCard extends StatelessWidget {
  final PillReminder reminder;
  final Function(PillReminder) onTaken;
  final Function(PillReminder) onSkip;
  final Function(PillReminder) onReschedule;

  const PillReminderCard({
    super.key,
    required this.reminder,
    required this.onTaken,
    required this.onSkip,
    required this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: primary.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time and Name Header
            Row(
              children: [
                Icon(Icons.access_time, color: primary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    reminder.medicationName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    reminder.time.format(context),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Schedule, Duration, etc.
            Text(
              'Schedule: ${reminder.schedule} | Duration: ${reminder.durationDays} days',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),

            // Display Start Date
            Text(
              'Start Date: ${reminder.startDate.day}/${reminder.startDate.month}/${reminder.startDate.year}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const Divider(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => onReschedule(reminder),
                  child: const Text('Reschedule'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => onSkip(reminder),
                  child: const Text('Skip'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => onTaken(reminder),
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  child: const Text(
                    'NOW',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
