import 'package:flutter/material.dart';

// --- Pill Reminder Data Model ---
class PillReminder {
  final String medicationName;
  final String schedule; // e.g., 'Daily', 'Twice a week'
  final TimeOfDay time;
  final DateTime startDate;
  final int repeatDays; // e.g., 0 for daily, 7 for weekly (simplified in form)
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

  // Constructor requires 'isGuest' flag from routes.dart
  const PillReminderScreen({super.key, required this.isGuest});

  @override
  State<PillReminderScreen> createState() => _PillReminderScreenState();
}

class _PillReminderScreenState extends State<PillReminderScreen> {
  // List to hold all user reminders (starts empty)
  final List<PillReminder> _reminders = [];

  // --- Functions for user actions (Point 3) ---

  void _markAsTaken(PillReminder reminder) {
    // Logic for marking pill as taken (e.g., logging it, updating status)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${reminder.medicationName} marked as taken!')),
    );
  }

  void _skipReminder(PillReminder reminder) {
    // Logic for skipping the pill (e.g., recording the skip)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${reminder.medicationName} skipped.')),
    );
  }

  void _rescheduleReminder(PillReminder reminder) {
    // Logic for rescheduling (e.g., opening a time picker)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${reminder.medicationName} rescheduled.')),
    );
  }

  // --- Function to add a new reminder (Updated for Sliders/Pickers) ---

  void _showAddReminderSheet() {
    // Local State Variables for the Form (reset on each open)
    String selectedSchedule = 'Daily';
    double durationInDays = 7;
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    TextEditingController nameController = TextEditingController();

    // Add Calendar to add date
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

    // Add Clock to add time
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
        // Use StateSetter for local state changes inside the BottomSheet
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            // Schedule options list (moved inside builder for scope)
            List<String> scheduleOptions = [
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
                          items: scheduleOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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

                    // Date Picker (Calendar)
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

                    // Time Picker (Clock)
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
                      max: 90, // Max 90 days for example
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
                          // Update the main screen state
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
                            nameController.dispose();
                          });
                        }
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

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isGuest ? 'Pill Reminder (Guest)' : 'Pill Reminder'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),

      // Point 1: Content based on reminder list state
      body: _reminders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_filled,
                    size: 80,
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Start to add your reminder", // Point 1: Text in the middle
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
              // Point 2: List of added reminders
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

      // Point 1: Add button on the side
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderSheet,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// --- Widget to display a single reminder (Point 2 & 3) ---
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

            // Point 3: Action Buttons
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    'NOW',
                    style: TextStyle(color: Colors.white),
                  ), // Check reminder by clicking NOW
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
