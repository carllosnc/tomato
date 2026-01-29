import '/imports.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import 'components/focus_break_timer.dart';
import 'components/focus_break_timer_task.dart';

class FocusBreakPage extends StatefulWidget {
  const FocusBreakPage({super.key});

  @override
  State<FocusBreakPage> createState() => _FocusBreakPageState();
}

class _FocusBreakPageState extends State<FocusBreakPage> with SharedState, LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        focusBreakState.resetAll(
          context: context,
          onReset: () {
            context.go("$homePath/");
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              focusBreakState.resetAll(
                context: context,
                onReset: () {
                  context.go("$homePath/");
                },
              );
            },
          ),
          title: "FOCUS AND BREAK".localize.pageTitle,
        ),
        floatingActionButton: const FocusBreakTimerTask(),
        body: const Center(
          child: SingleChildScrollView(
            child: FocusBreak(),
          ),
        ),
      ),
    );
  }
}
