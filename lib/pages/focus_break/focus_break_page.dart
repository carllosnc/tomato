import '/imports.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'components/focus_break_timer.dart';
import 'components/focus_break_timer_task.dart';

class FocusBreakPage extends StatefulWidget {
  const FocusBreakPage({super.key});

  @override
  State<FocusBreakPage> createState() => _FocusBreakPageState();
}

class _FocusBreakPageState extends State<FocusBreakPage> with SharedState {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              focusBreakState.resetAll(
                context: context,
                onReset: () {
                  context.go("/");
                },
              );
            },
            icon: const Icon(Icons.close),
          ),
          title: const Text(
            "FOCUS AND BREAK",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            focusBreakTask(context);
          },
          label: const Text("Task"),
          icon: const Icon(Icons.timer),
        ),
        body: const Center(
          child: SingleChildScrollView(
            child: FocusBreak(),
          ),
        ),
      ),
    );
  }
}
