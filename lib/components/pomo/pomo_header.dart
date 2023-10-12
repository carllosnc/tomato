import 'package:flutter/material.dart';
import '/imports/app.dart';

class PomoHeader extends StatefulWidget {
  const PomoHeader({super.key});

  @override
  State<PomoHeader> createState() => _PomoHeaderState();
}

class _PomoHeaderState extends State<PomoHeader> with TimerMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          timer.showStatus(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 30),
        Text(
          timer.name.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 6,
            color: Colors.yellowAccent.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 10,
          children: [
            Text(
              "Focus: ${timer.formatDurationDescription(timer.workDuration)}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
              ),
            ),
            const Text("•"),
            Text(
              "Break: ${timer.formatDurationDescription(timer.breakDuration)}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
