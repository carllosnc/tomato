class LastTimeSince {
  final String title;
  final String? description;
  final DateTime time;

  LastTimeSince({
    required this.title,
    this.description,
    required this.time,
  });

  factory LastTimeSince.fromJson(Map<String, dynamic> json) {
    return LastTimeSince(
      title: json['title'] as String,
      description: json['description'] as String?,
      time: DateTime.parse(json['time'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'time': time.toIso8601String(),
    };
  }

  static String asSql() {
    return '''
    CREATE TABLE IF NOT EXISTS last_time_since (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      time TEXT
    );
    ''';
  }
}
