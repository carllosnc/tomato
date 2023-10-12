import '/imports/app.dart';
import 'package:flutter/material.dart';
import 'pomo_controls.dart';
import 'pomo_header.dart';
import 'pomo_time_indicator.dart';

class Pomo extends StatefulWidget {
  const Pomo({
    super.key,
  });

  @override
  State<Pomo> createState() => PomoState();
}

class PomoState extends State<Pomo> with TimerMixin {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PomoHeader(),
        SizedBox(height: 30),
        PomoTimerIndicator(),
        SizedBox(height: 20),
        PomoControls(),
      ],
    );
  }
}
