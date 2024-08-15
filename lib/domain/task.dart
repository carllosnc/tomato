enum TimerType { task, pause }

class Timer {
  final String name;
  final int duration;
  final TimerType type;
  final int id;
  final int position;

  Timer({
    required this.type,
    required this.name,
    required this.duration,
    required this.id,
    required this.position,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type == TimerType.task ? 'focus' : 'pause',
      'name': name,
      'duration': duration,
      'position': position,
      'id': id,
    };
  }

  static Timer fromJson(Map<String, dynamic> json) {
    return Timer(
      type: json['type'] == 'focus' ? TimerType.task : TimerType.pause,
      name: json['name'],
      duration: json['duration'],
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
      duration INTEGER
      position INTEGER
    );
    ''';
  }
}
