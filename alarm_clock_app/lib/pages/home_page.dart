import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/alarm_model.dart';
import 'set_alarm_page.dart';
import '../services/notification_service.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Alarm> alarms = [];

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('hh:mm:ss a').format(DateTime.now());
    final date = DateFormat('EEE, MMM d, yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('⏰ Alarm Clock')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(child: Text(time, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold))),
          Text(date, style: const TextStyle(fontSize: 20, color: Colors.grey)),

          const SizedBox(height: 30),
          const Text('Your Alarms', style: TextStyle(fontSize: 20)),
          Expanded(
            child: ListView.builder(
              itemCount: alarms.length,
              itemBuilder: (context, index) {
                final alarm = alarms[index];
                return ListTile(
                  title: Text(DateFormat('hh:mm a').format(alarm.time)),
                  subtitle: Text(alarm.label),
                  trailing: Switch(
                    value: alarm.isEnabled,
                    onChanged: (val) {
                      setState(() {
                        alarm.isEnabled = val;
                      });
                      if (val) {
                        NotificationService.showScheduledNotification(alarm.time, index);
                      } else {
                        NotificationService.cancelNotification(index);
                      }
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SetAlarmPage()),
          );
          if (result != null && result is Alarm) {
            setState(() {
              alarms.add(result);
              NotificationService.showScheduledNotification(result.time, alarms.length - 1);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
