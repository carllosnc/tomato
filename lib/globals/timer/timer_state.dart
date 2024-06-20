import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

enum PomoType { work, relax }

class _Timer extends ChangeNotifier {
  Timer? countdownTimer;
  PomoType pomoType = PomoType.work;
  bool isRunning = false;
  num percent = 0;
  bool autoplay = false;
  Duration workDuration = const Duration(minutes: 25);
  Duration breakDuration = const Duration(minutes: 5);
  String name = "My Task";

  late Duration currentDuration = workDuration;
  late Duration currentTime = workDuration;

  Duration oneSec = const Duration(seconds: 1);

  // This function is used to set task name
  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  // This function is used to set the work duration
  void toggleAction() {
    if (isRunning) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  // This function is used to start the timer
  void startTimer() {
    notifyListeners();

    isRunning = true;

    countdownTimer = Timer.periodic(oneSec, (timer) {
      if (currentDuration.inSeconds == 0) {
        timer.cancel();
        reset();
      } else {
        tictac();
      }
    });
  }

  // This function is used to stop the timer
  void stopTimer() {
    notifyListeners();

    isRunning = false;
    countdownTimer!.cancel();
  }

  void tictac() {
    notifyListeners();

    currentDuration = currentDuration - oneSec;
    percent = 1 - (currentDuration.inSeconds / currentTime.inSeconds);
  }

  // This function is used to reset the timer
  void reset() {
    notifyListeners();

    Vibration.vibrate(duration: 1000);

    currentDuration = currentTime;
    percent = 0;

    isRunning = false;

    if (pomoType == PomoType.work) {
      currentDuration = breakDuration;
      currentTime = breakDuration;
      pomoType = PomoType.relax;
    } else {
      currentDuration = workDuration;
      currentTime = workDuration;
      pomoType = PomoType.work;
    }

    if (autoplay) {
      startTimer();
    }
  }

  // This function is used to toggle the autoplay
  void toggleAutoplay(BuildContext context) {
    notifyListeners();

    autoplay = !autoplay;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: autoplay //
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        content: Text(
          autoplay ? "Autoplay enabled" : "Autoplay disabled",
        ),
        duration: const Duration(milliseconds: 700),
      ),
    );
  }

  // This function is used to reset all the timer
  void resetAll({
    required BuildContext context,
    Duration? newWorkDuration,
    Duration? newBreakDuration,
    String? newName,
    String? dialogTitle,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle ?? "Reset Timer"),
          content: const Text("Are you sure you want to reset the timer?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                countdownTimer?.cancel();
                name = newName ?? name;
                workDuration = newWorkDuration ?? workDuration;
                breakDuration = newBreakDuration ?? breakDuration;
                currentDuration = newWorkDuration ?? workDuration;
                currentTime = newWorkDuration ?? workDuration;
                percent = 0;
                isRunning = false;
                pomoType = PomoType.work;
                autoplay = false;

                notifyListeners();
              },
              child: const Text("Reset"),
            ),
          ],
        );
      },
    );
  }

  // This function is used to show the status of the timer
  String showStatus() {
    if (isRunning) {
      if (pomoType == PomoType.work) {
        return "👨‍💻 Time to focus";
      } else {
        return "🧘‍♂️ Take a break";
      }
    }

    return "😐 Paused";
  }

  // This function is used to format the duration
  String formatDuration(Duration d) {
    String twoDigitMinutes = d.inMinutes.remainder(60).toString();
    String twoDigitSeconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  // This function is used to format the duration description
  String formatDurationDescription(Duration d) {
    if (d.inSeconds < 60) {
      return "${d.inSeconds} s";
    } else {
      return "${d.inMinutes} min";
    }
  }
}

var timer = _Timer();
