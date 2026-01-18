class LastTimeSince {
  final int? id;
  final String title;
  final DateTime time;

  LastTimeSince({
    this.id,
    required this.title,
    required this.time,
  });

  factory LastTimeSince.fromJson(Map<String, dynamic> json) {
    return LastTimeSince(
      id: json['id'] as int?,
      title: json['title'] as String,
      time: DateTime.parse(json['time'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'time': time.toIso8601String(),
    };
  }

  static String asSql() {
    return '''
    CREATE TABLE IF NOT EXISTS last_time_since (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      time TEXT
    );
    ''';
  }
}
