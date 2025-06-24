import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/alarm_model.dart';
import 'package:intl/intl.dart';

class SetAlarmPage extends StatefulWidget {
  const SetAlarmPage({super.key});
  @override
  State<SetAlarmPage> createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) {
      setState(() => selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final alarmTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);

    return Scaffold(
      appBar: AppBar(title: const Text("Set New Alarm")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('hh:mm a').format(alarmTime), style: const TextStyle(fontSize: 40)),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Pick Time'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final alarm = Alarm(time: alarmTime);
                Navigator.pop(context, alarm);
              },
              child: const Text("Save Alarm"),
            ),
          ],
        ),
      ),
    );
  }
}
