import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

part './pomo_controls.dart';
part './pomo_time_indicator.dart';
part './pomo_header.dart';

enum PomoType { work, relax }

class Pomo extends StatefulWidget {
  final Duration workDuration;
  final Duration relaxDuration;
  final String name;

  const Pomo({
    super.key,
    required this.workDuration,
    required this.relaxDuration,
    required this.name,
  });

  @override
  State<Pomo> createState() => PomoState();
}

class PomoState extends State<Pomo> {
  Timer? countdownTimer;

  late Duration duration;
  late Duration currentTime;
  PomoType pomoType = PomoType.work;
  Duration oneSec = const Duration(seconds: 1);
  bool isRunning = false;
  num percent = 0;
  bool autoplay = false;

  @override
  void initState() {
    super.initState();

    duration = widget.workDuration;
    currentTime = widget.workDuration;
  }

  void toggleAction() {
    if (isRunning) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    setState(() {
      isRunning = true;
    });

    countdownTimer = Timer.periodic(oneSec, (timer) {
      if (duration.inSeconds == 0) {
        timer.cancel();
        reset();
      } else {
        tictac();
      }
    });
  }

  void stopTimer() {
    setState(() {
      isRunning = false;
    });

    countdownTimer!.cancel();
  }

  void tictac() {
    setState(() {
      duration = duration - oneSec;
      percent = 1 - (duration.inSeconds / currentTime.inSeconds);
    });
  }

  void reset() {
    Vibration.vibrate(duration: 1000);

    setState(() {
      duration = currentTime;
      percent = 0;

      isRunning = false;

      if (pomoType == PomoType.work) {
        duration = widget.relaxDuration;
        currentTime = widget.relaxDuration;
        pomoType = PomoType.relax;
      } else {
        duration = widget.workDuration;
        currentTime = widget.workDuration;
        pomoType = PomoType.work;
      }
    });

    if (autoplay) {
      startTimer();
    }
  }

  void toggleAutoplay() {
    setState(() {
      autoplay = !autoplay;

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: autoplay
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          content: Text(
            autoplay ? "Autoplay enabled" : "Autoplay disabled",
          ),
          duration: const Duration(milliseconds: 700),
        ),
      );
    });
  }

  void resetAll() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reset"),
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

                setState(() {
                  duration = widget.workDuration;
                  currentTime = widget.workDuration;
                  percent = 0;
                  isRunning = false;
                  pomoType = PomoType.work;
                  autoplay = false;
                });
              },
              child: const Text("Reset"),
            ),
          ],
        );
      },
    );
  }

  String showStatus() {
    if (isRunning) {
      if (pomoType == PomoType.work) {
        return "👨‍💻 Time to focus";
      } else {
        return "🧘‍♂️ Relaxing";
      }
    }

    return "😐  Paused";
  }

  String formatDuration(Duration d) {
    String twoDigitMinutes = d.inMinutes.remainder(60).toString();
    String twoDigitSeconds =
        d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String formatDurationDescription(Duration d) {
    if (d.inSeconds < 60) {
      return "${d.inSeconds}s";
    } else {
      return "${d.inMinutes}min";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        header(),
        const SizedBox(height: 30),
        timeIndicator(),
        const SizedBox(height: 20),
        controls(),
      ],
    );
  }
}
