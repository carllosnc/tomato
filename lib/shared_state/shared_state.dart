import 'package:flutter/material.dart';
import 'focus_break_state.dart';
import 'multiple_timers_state.dart';
import 'sound_state.dart';
import 'last_time_since_state.dart';

mixin SharedState<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    focusBreakState.addListener(action);
    multipleTimersState.addListener(action);
    soundState.addListener(action);
    lastTimeSinceState.addListener(action);
  }

  @override
  void dispose() {
    super.dispose();
    focusBreakState.removeListener(action);
    multipleTimersState.removeListener(action);
    soundState.removeListener(action);
    lastTimeSinceState.removeListener(action);
  }

  action() {
    setState(() {});
  }
}
