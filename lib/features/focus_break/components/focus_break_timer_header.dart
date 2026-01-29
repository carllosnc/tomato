import 'package:vw/vw.dart';
import 'package:localize/localize.dart';

import '/imports.dart';
import 'package:flutter/material.dart';

class FocusBreakHeader extends StatefulWidget {
  const FocusBreakHeader({super.key});

  @override
  State<FocusBreakHeader> createState() => _FocusBreakHeaderState();
}

class _FocusBreakHeaderState extends State<FocusBreakHeader> with SharedState, LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return VWColumn(
      horizontalAlignment: CrossAxisAlignment.center,
      gap: 20,
      children: [
        Text(
          focusBreakState.showStatus().localize,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          focusBreakState.name.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 6,
            color: Colors.yellowAccent.withValues(alpha: 0.9),
          ),
        ),
        Wrap(
          spacing: 10,
          children: [
            Text(
              "${"Focus: ".localize}${focusBreakState.formatDurationDescription(focusBreakState.workDuration)}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
              ),
            ),
            const Text("•"),
            Text(
              "${"Break: ".localize}${focusBreakState.formatDurationDescription(focusBreakState.breakDuration)}",
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
