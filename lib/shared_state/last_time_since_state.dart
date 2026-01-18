import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/imports.dart';

class _LastTimeSinceState extends ChangeNotifier {
  late Future<Database> _database;

  List<LastTimeSince> items = [];
  bool isLoading = false;

  init() async {
    _database = openDatabase(
      'tomato.db',
      version: 1,
      onCreate: (db, int version) async {
        await db.execute(CustomTimer.asSql());
        await db.execute(LastTimeSince.asSql());
      },
    );

    // Ensure table exists even if DB already existed
    final db = await _database;
    await db.execute(LastTimeSince.asSql());

    await getAll();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();

    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('last_time_since');

    items = maps.map((e) => LastTimeSince.fromJson(e)).toList();

    // transform string to DateTime to sort
    items.sort((a, b) => b.time.compareTo(a.time));

    isLoading = false;
    notifyListeners();
  }

  Future<void> add(LastTimeSince item) async {
    isLoading = true;
    notifyListeners();

    final db = await _database;
    await db.insert('last_time_since', item.toJson());

    await getAll();

    isLoading = false;
    notifyListeners();
  }

  Future<void> delete(int id) async {
    isLoading = true;
    notifyListeners();

    final db = await _database;
    await db.delete('last_time_since', where: 'id = ?', whereArgs: [id]);

    await getAll();

    isLoading = false;
    notifyListeners();
  }
}

final lastTimeSinceState = _LastTimeSinceState();
