import 'package:flutter/material.dart';

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
  final List<PillReminder> _reminders = [];

  void _markAsTaken(PillReminder reminder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${reminder.medicationName} marked as taken!')),
    );
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

  void _showAddReminderSheet() {
    String selectedSchedule = 'Daily';
    double durationInDays = 7;
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    final TextEditingController nameController = TextEditingController();

    Future<void> selectDate(
      BuildContext context,
      StateSetter setModalState,
    ) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        setModalState(() {
          selectedDate = picked;
        });
      }
    }

    Future<void> selectTime(
      BuildContext context,
      StateSetter setModalState,
    ) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (picked != null && picked != selectedTime) {
        setModalState(() {
          selectedTime = picked;
        });
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final List<String> scheduleOptions = [
              'Daily',
              'Weekly',
              'Monthly',
              'As Needed',
            ];

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'New Pill Reminder Setup',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const Divider(),
                    const SizedBox(height: 20),

                    // Medication Name
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Medication Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Schedule Dropdown
                    InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Schedule',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedSchedule,
                          isExpanded: true,
                          items: scheduleOptions
                              .map(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setModalState(() {
                                selectedSchedule = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Date Picker
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Start Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => selectDate(context, setModalState),
                          icon: const Icon(Icons.calendar_today),
                          label: const Text('Pick Date'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Time Picker
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Time: ${selectedTime.format(context)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => selectTime(context, setModalState),
                          icon: const Icon(Icons.access_time),
                          label: const Text('Pick Time'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Duration Slider
                    Text(
                      'Duration: ${durationInDays.toInt()} Days',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: durationInDays,
                      min: 1,
                      max: 90,
                      divisions: 89,
                      label: durationInDays.round().toString(),
                      onChanged: (double value) {
                        setModalState(() {
                          durationInDays = value;
                        });
                      },
                    ),
                    const SizedBox(height: 30),

                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty) {
                          Navigator.of(ctx).pop();
                          setState(() {
                            _reminders.add(
                              PillReminder(
                                medicationName: nameController.text,
                                schedule: selectedSchedule,
                                time: selectedTime,
                                startDate: selectedDate,
                                repeatDays: 0,
                                durationDays: durationInDays.toInt(),
                              ),
                            );
                          });
                        }
                        nameController.dispose();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Save Reminder'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isGuest ? 'Pill Reminder (Guest)' : 'Pill Reminder'),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: _reminders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_filled,
                    size: 80,
                    // If your SDK warns on withOpacity, switch to withValues
                    // ignore: deprecated_member_use
                    color: primary.withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Start to add your reminder",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Tap the '+' button to set your first medication schedule.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                final reminder = _reminders[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: ReminderCard(
                    reminder: reminder,
                    onTaken: _markAsTaken,
                    onSkip: _skipReminder,
                    onReschedule: _rescheduleReminder,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderSheet,
        backgroundColor: primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// --- Widget to display a single reminder ---
class ReminderCard extends StatelessWidget {
  final PillReminder reminder;
  final Function(PillReminder) onTaken;
  final Function(PillReminder) onSkip;
  final Function(PillReminder) onReschedule;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onTaken,
    required this.onSkip,
    required this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medication Name and Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reminder.medicationName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                Text(
                  reminder.time.format(context),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

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
