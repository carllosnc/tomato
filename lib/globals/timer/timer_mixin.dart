import 'package:flutter/material.dart';
import './timer_state.dart';

mixin TimerMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    timer.addListener(action);
  }

  @override
  void dispose() {
    super.dispose();
    timer.removeListener(action);
  }

  action() {
    setState(() {});
  }
}
