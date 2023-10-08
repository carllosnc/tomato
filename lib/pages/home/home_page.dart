import 'dart:async';
import 'package:flutter/material.dart';
import '/imports/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstTime = SharedPrefs().prefs.getBool('welcome') ?? true;

  Timer? countdownTimer;

  Duration duration = const Duration(seconds: 60);
  Duration currentTime = const Duration(seconds: 60);
  Duration oneSec = const Duration(seconds: 1);
  bool isRunning = false;
  num percent = 0;

  void action() {
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
    setState(() {
      duration = currentTime;
      percent = 0;
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      return Welcome(
        onPressed: () {
          setState(() {
            firstTime = false;
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            //logo and title
            Image.asset(
              Assets.logo,
              width: 30,
            ),
            const SizedBox(width: 12),
            const Text("Tomato"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Timers"),
        icon: const Icon(Icons.timer),
      ),
      body: const Pomo(
        workDuration: Duration(seconds: 10),
        relaxDuration: Duration(seconds: 5),
        name: "Esturdar C#",
      ),
    );
  }
}
