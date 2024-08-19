import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/imports.dart';

class _MultipleTasksState extends ChangeNotifier {
  late Future<Database> _database;

  List<Timer> allTasks = [];
  bool isLoading = false;

  init() async {
    _database = openDatabase(
      'tomato.db',
      version: 1,
      onCreate: (db, int version) async {
        await db.execute(Timer.asSql());
      },
    );
  }

  Future<void> getAll() async {
    isLoading = true;

    final List<Map<String, dynamic>> tasks = await _database.then((value) {
      return value.query('tasks');
    });

    isLoading = false;

    allTasks = tasks.map((e) => Timer.fromJson(e)).toList();
    //order by position
    allTasks.sort((a, b) => a.position.compareTo(b.position));

    notifyListeners();
  }

  Future<void> add(Timer timer) async {
    isLoading = true;

    await _database.then((value) {
      return value.insert('tasks', timer.toJson());
    });

    await getAll();

    isLoading = false;
  }

  Future<void> delete(int id, int position) async {
    isLoading = true;

    await _database.then((value) {
      return value.delete('tasks', where: 'id = ?', whereArgs: [id]);
    });

    dynamic subSequenceItems = await _database.then((value) {
      return value.query('tasks', where: 'position > ?', whereArgs: [position]);
    });

    for (var item in subSequenceItems) {
      await _database.then((value) {
        return value.update(
          'tasks',
          {'position': item['position'] - 1},
          where: 'id = ?',
          whereArgs: [item['id']],
        );
      });
    }

    await getAll();

    isLoading = false;
  }

  Future<void> update(Timer timer) async {
    isLoading = true;

    await _database.then((value) {
      return value.update(
        'tasks',
        timer.toJson(),
        where: 'id = ?',
        whereArgs: [timer.id],
      );
    });

    await getAll();

    isLoading = false;
  }

  updatePosition(int oldPosition, int newPosition) async {
    isLoading = true;

    // movie item to below
    if (newPosition > oldPosition) {
      dynamic items = await _database.then((value) {
        return value.query(
          'tasks',
          where: 'position > ? AND position < ?',
          whereArgs: [oldPosition, newPosition],
        );
      });

      await _database.then((value) {
        value.update(
          'tasks',
          {'position': newPosition - 1},
          where: 'position = ?',
          whereArgs: [oldPosition],
        );
      });

      for (var item in items) {
        await _database.then((value) {
          value.update(
            'tasks',
            {'position': item['position'] - 1},
            where: 'id = ?',
            whereArgs: [item['id']],
          );
        });
      }
    }

    // move item to above
    if (newPosition < oldPosition) {
      dynamic items = await _database.then((value) {
        return value.query(
          'tasks',
          where: 'position < ? AND position >= ?',
          whereArgs: [oldPosition, newPosition],
        );
      });

      await _database.then((value) {
        value.update(
          'tasks',
          {'position': newPosition},
          where: 'position = ?',
          whereArgs: [oldPosition],
        );
      });

      for (var item in items) {
        _database.then((value) {
          value.update(
            'tasks',
            {'position': item['position'] + 1},
            where: 'id = ?',
            whereArgs: [item['id']],
          );
        });
      }
    }

    await getAll();

    isLoading = false;
  }
}

final multipleTasksState = _MultipleTasksState();
