import 'package:flutter/material.dart';
import '/imports.dart';

class FocusBreakHeader extends StatefulWidget {
  const FocusBreakHeader({super.key});

  @override
  State<FocusBreakHeader> createState() => _FocusBreakHeaderState();
}

class _FocusBreakHeaderState extends State<FocusBreakHeader> with SharedState {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          timerFocusState.showStatus(),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          timerFocusState.name.toUpperCase(),
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
              "Focus: ${timerFocusState.formatDurationDescription(timerFocusState.workDuration)}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
              ),
            ),
            const Text("•"),
            Text(
              "Break: ${timerFocusState.formatDurationDescription(timerFocusState.breakDuration)}",
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
