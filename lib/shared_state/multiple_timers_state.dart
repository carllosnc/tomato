import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vibration/vibration.dart';
import '/imports.dart';

enum ActionState {
  clean,
  running,
  paused,
  finished;

  @override
  toString() {
    switch (this) {
      case ActionState.clean:
        return 'Clean';
      case ActionState.running:
        return 'Running...';
      case ActionState.paused:
        return 'Paused';
      case ActionState.finished:
        return 'Tasks finished';
    }
  }
}

class _MultipleTimersState extends ChangeNotifier {
  late Future<Database> _database;

  List<CustomTimer> allTimers = [];
  List<CustomTimer> finishedTimers = [];
  Timer? currentCountdownTimer;
  bool isLoading = false;
  CustomTimer? currentTimer;
  Duration? currentDuration;
  ActionState actionState = ActionState.clean;
  bool autoStart = true;

  init() async {
    _database = openDatabase(
      'tomato.db',
      version: 1,
      onCreate: (db, int version) async {
        await db.execute(CustomTimer.asSql());
      },
    );
  }

  Future<void> getAll() async {
    isLoading = true;

    final List<Map<String, dynamic>> timers = await _database.then((value) {
      return value.query('tasks');
    });

    isLoading = false;

    allTimers = timers.map((e) => CustomTimer.fromJson(e)).toList();
    //order by position
    allTimers.sort((a, b) => a.position.compareTo(b.position));

    if (allTimers.isNotEmpty) {
      setCurrentTimer(allTimers.first);
    }

    notifyListeners();
  }

  Future<void> add(CustomTimer timer) async {
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

  Future<void> update(CustomTimer timer) async {
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
        await _database.then((value) {
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

  setCurrentTimer(CustomTimer timer) {
    currentTimer = timer;
    currentDuration = Duration(minutes: timer.duration);
    notifyListeners();
  }

  setFinishedTimer(CustomTimer timer) {
    finishedTimers.add(timer);
    notifyListeners();
  }

  toggleAutoStart() {
    autoStart = !autoStart;
    notifyListeners();
  }

  goToNextTimer() {
    int length = allTimers.length;

    if (currentTimer != null && currentTimer!.position < length - 1) {
      setCurrentTimer(allTimers[currentTimer!.position + 1]);
      return;
    }

    pauseCurrentCountdownTimer();
    setCurrentTimer(allTimers.first);

    finishAllTimers();

    return;
  }

  finishAllTimers() {
    if (allTimers.length == finishedTimers.length) {
      actionState = ActionState.finished;
      notifyListeners();
    }
  }

  startCurrentCountdownTimer() {
    actionState = ActionState.running;
    notifyListeners();

    currentCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentDuration = currentDuration! - const Duration(seconds: 1);

      if (currentDuration!.inSeconds == 0) {
        if (soundState.allowSound) {
          AudioPlayer().play(AssetSource('sounds/bell.wav'));
        }

        Vibration.vibrate(duration: 1000);

        setFinishedTimer(currentTimer!);

        if (autoStart) {
          goToNextTimer();
        } else {
          pauseCurrentCountdownTimer();
          finishAllTimers();
        }

        notifyListeners();
      }

      notifyListeners();
    });
  }

  resetAllTimers() {
    currentCountdownTimer?.cancel();

    if (allTimers.isNotEmpty) {
      currentTimer = allTimers.first;
      currentDuration = Duration(minutes: currentTimer!.duration);
    }

    finishedTimers.clear();
    actionState = ActionState.clean;

    notifyListeners();
  }

  pauseCurrentCountdownTimer() {
    actionState = ActionState.paused;
    currentCountdownTimer!.cancel();

    notifyListeners();
  }

  manualStart() {
    if (multipleTimersState.autoStart == false && finishedTimers.isNotEmpty) {
      multipleTimersState.goToNextTimer();
    }

    multipleTimersState.startCurrentCountdownTimer();
  }
}

final multipleTimersState = _MultipleTimersState();
