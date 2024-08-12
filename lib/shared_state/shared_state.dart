import 'package:flutter/material.dart';
import 'timer_focus_state.dart';

mixin SharedState<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    timerFocusState.addListener(action);
  }

  @override
  void dispose() {
    super.dispose();
    timerFocusState.removeListener(action);
  }

  action() {
    setState(() {});
  }
}
