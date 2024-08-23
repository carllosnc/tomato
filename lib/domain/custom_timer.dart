enum CustomTimerType { task, pause }

class CustomTimer {
  final String name;
  final int duration;
  final CustomTimerType type;
  final int? id;
  final int position;

  CustomTimer({
    required this.type,
    required this.name,
    required this.duration,
    this.id,
    required this.position,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type == CustomTimerType.task ? 'focus' : 'pause',
      'name': name,
      'duration': duration,
      'position': position,
      'id': id,
    };
  }

  static CustomTimer fromJson(Map<String, dynamic> json) {
    return CustomTimer(
      type: json['type'] == 'focus'
          ? CustomTimerType.task
          : CustomTimerType.pause,
      name: json['name'],
      duration: Duration(minutes: json['duration']).inMinutes,
      position: json['position'],
      id: json['id'],
    );
  }

  static asSql() {
    return '''
    CREATE TABLE IF NOT EXISTS tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT,
      name TEXT,
      duration INTEGER,
      position INTEGER
    );
    ''';
  }
}
