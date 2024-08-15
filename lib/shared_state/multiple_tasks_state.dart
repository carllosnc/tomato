import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/imports.dart';

class _MultipleTasksState extends ChangeNotifier {
  late Future<Database> _database;

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
}

final multipleTasksState = _MultipleTasksState();
