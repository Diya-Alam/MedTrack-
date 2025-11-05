import 'package:flutter/material.dart';

// --- Health Metric Data Model ---
class HealthRecord {
  final String metric; // e.g., 'Weight', 'Blood Pressure'
  final String value;
  final DateTime timestamp;

  HealthRecord({
    required this.metric,
    required this.value,
    required this.timestamp,
  });
}

// --- Health Monitor Screen Widget ---
class HealthMonitorScreen extends StatefulWidget {
  const HealthMonitorScreen({super.key});

  @override
  State<HealthMonitorScreen> createState() => _HealthMonitorScreenState();
}

class _HealthMonitorScreenState extends State<HealthMonitorScreen> {
  // Mock data for the most recent reading of each metric
  final Map<String, HealthRecord> _latestRecords = {
    'Weight': HealthRecord(
      metric: 'Weight',
      value: '75.5 kg',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    'Blood Pressure': HealthRecord(
      metric: 'Blood Pressure',
      value: '120/80',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    'Glucose': HealthRecord(
      metric: 'Glucose',
      value: '95 mg/dL',
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    'Hydration': HealthRecord(
      metric: 'Hydration',
      value: '2.5 L',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  };

  final Map<String, IconData> _metricIcons = {
    'Weight': Icons.scale, // Scale icon
    'Blood Pressure':
        Icons.monitor_heart, // Digital meter icon (using monitor_heart)
    'Glucose': Icons.opacity, // Droplet icon
    'Hydration': Icons.water_drop_outlined, // Water droplet
  };

  // --- Function to add a new health record ---
  void _showAddRecordSheet() {
    String selectedMetric = _metricIcons.keys.first;
    TextEditingController valueController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
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
                      'Log New Health Record',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const Divider(),
                    const SizedBox(height: 20),

                    // Metric Dropdown Selector
                    InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Select Metric',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedMetric,
                          isExpanded: true,
                          items: _metricIcons.keys.map((String metric) {
                            return DropdownMenuItem<String>(
                              value: metric,
                              child: Row(
                                children: [
                                  Icon(_metricIcons[metric]),
                                  const SizedBox(width: 10),
                                  Text(metric),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setModalState(() {
                                selectedMetric = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Value Input
                    TextField(
                      controller: valueController,
                      keyboardType: selectedMetric.contains('Blood Pressure')
                          ? TextInputType
                                .text // For 120/80
                          : TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Value (${selectedMetric.split(' ').first})',
                        hintText: selectedMetric == 'Blood Pressure'
                            ? 'e.g., 120/80'
                            : 'e.g., 75.5',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        if (valueController.text.isNotEmpty) {
                          // Update the main screen state with the new record
                          setState(() {
                            _latestRecords[selectedMetric] = HealthRecord(
                              metric: selectedMetric,
                              value:
                                  valueController.text +
                                  (selectedMetric == 'Weight'
                                      ? ' kg'
                                      : selectedMetric == 'Glucose'
                                      ? ' mg/dL'
                                      : selectedMetric == 'Hydration'
                                      ? ' L'
                                      : ''),
                              timestamp: DateTime.now(),
                            );
                            Navigator.of(ctx).pop();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Save Record'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Monitor'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Latest Readings',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Quick access to log new metrics and view recent stats.',
              style: TextStyle(color: Colors.black54),
            ),
            const Divider(height: 30),

            // Grid of Health Trackers
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _latestRecords.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.0, // Make cards square
              ),
              itemBuilder: (context, index) {
                String metricName = _latestRecords.keys.elementAt(index);
                HealthRecord record = _latestRecords[metricName]!;
                IconData icon = _metricIcons[metricName]!;

                return HealthMetricCard(
                  metricName: metricName,
                  icon: icon,
                  latestValue: record.value,
                  lastRecorded: record.timestamp,
                  onTap:
                      _showAddRecordSheet, // Tapping any card opens the logger
                );
              },
            ),

            const SizedBox(height: 30),

            // Placeholder for Graph/Report Section
            Text(
              'Metric Trends (Coming Soon)',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              alignment: Alignment.center,
              child: const Text('Interactive Line Graph Placeholder'),
            ),
          ],
        ),
      ),

      // Floating button to quickly add a record
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddRecordSheet,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_chart),
        label: const Text('Log Record'),
      ),
    );
  }
}

// --- Widget for a single metric card ---
class HealthMetricCard extends StatelessWidget {
  final String metricName;
  final IconData icon;
  final String latestValue;
  final DateTime lastRecorded;
  final VoidCallback onTap;

  const HealthMetricCard({
    super.key,
    required this.metricName,
    required this.icon,
    required this.latestValue,
    required this.lastRecorded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon and Metric Name
              Row(
                children: [
                  Icon(icon, color: Theme.of(context).primaryColor, size: 28),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      metricName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              // Latest Value
              Text(
                latestValue,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),

              // Timestamp
              Text(
                'Last: ${_getTimeAgo(lastRecorded)}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final duration = DateTime.now().difference(time);
    if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}h ago';
    } else {
      return '${duration.inDays}d ago';
    }
  }
}
