import '/imports.dart';
import 'package:flutter/material.dart';
import 'focus_break_timer_controls.dart';
import 'focus_break_timer_header.dart';
import 'focus_break_timer_indicator.dart';

class FocusBreak extends StatefulWidget {
  const FocusBreak({
    super.key,
  });

  @override
  State<FocusBreak> createState() => FocusBreakState();
}

class FocusBreakState extends State<FocusBreak> with SharedState {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FocusBreakHeader(),
        SizedBox(height: 30),
        FocusBreakIndicator(),
        SizedBox(height: 20),
        FocusBreakControls(),
      ],
    );
  }
}
