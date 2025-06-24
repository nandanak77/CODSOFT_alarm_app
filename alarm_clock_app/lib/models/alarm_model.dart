class Alarm {
  final DateTime time;
  final String label;
  bool isEnabled;

  Alarm({
    required this.time,
    this.label = 'Alarm',
    this.isEnabled = true,
  });
}
