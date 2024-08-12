import 'package:flutter/material.dart';
import 'focus_break_state.dart';

mixin SharedState<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    focusBreakState.addListener(action);
  }

  @override
  void dispose() {
    super.dispose();
    focusBreakState.removeListener(action);
  }

  action() {
    setState(() {});
  }
}
