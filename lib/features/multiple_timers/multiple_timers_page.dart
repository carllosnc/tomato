import 'package:flutter/material.dart';
import '/imports.dart';
import 'components/new_timer_button.dart';

class MultipleTimersPage extends StatelessWidget {
  const MultipleTimersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Multiple Timers".title,
        actions: const [
          NewTimerButton(),
        ],
      ),
      body: const Center(
        child: Text("Multiple Timers"),
      ),
    );
  }
}
