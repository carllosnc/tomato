import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vw/vw.dart';
import 'components/new_timer_button.dart';
import 'components/timer_card.dart';
import '/imports.dart';

class MultipleTimersPage extends StatefulWidget {
  const MultipleTimersPage({super.key});

  @override
  State<MultipleTimersPage> createState() => _MultipleTimersPageState();
}

class _MultipleTimersPageState extends State<MultipleTimersPage> with SharedState, TickerProviderStateMixin {
  late List<CustomTimer> allTasks;

  @override
  void initState() {
    multipleTimersState.getAll();
    allTasks = multipleTimersState.allTimers;
    super.initState();
  }

  Widget getActionButton() {
    if (multipleTimersState.actionState == ActionState.finished) {
      return IconButton.outlined(
        onPressed: () {
          multipleTimersState.resetAllTimers();
        },
        icon: const Icon(Icons.replay),
      );
    }

    if (multipleTimersState.actionState == ActionState.running) {
      return IconButton.outlined(
        onPressed: () {
          multipleTimersState.pauseCurrentCountdownTimer();
        },
        icon: const Icon(Icons.pause),
      );
    }

    return VWRow(
      gap: 10,
      children: [
        IconButton.outlined(
          onPressed: multipleTimersState.manualStart,
          icon: const Icon(Icons.play_arrow),
        ),
        if (multipleTimersState.actionState != ActionState.clean)
          IconButton.outlined(
            onPressed: () {
              resetAction();
            },
            icon: const Icon(Icons.replay),
          ),
      ],
    );
  }

  exitAction() {
    context.alert(
      title: "Exit",
      content: "Are you sure you want to exit? All timers will be reset.",
      cancelLabel: "Cancel",
      confirmLabel: "Exit",
      onConfirm: () {
        multipleTimersState.resetAllTimers();
        context.go("$homePath/");
      },
    );
  }

  resetAction() {
    context.alert(
      title: "Reset",
      content: "Are you sure you want to reset? All timers will be reset.",
      cancelLabel: "Cancel",
      confirmLabel: "Reset",
      onConfirm: () {
        multipleTimersState.resetAllTimers();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (cancel) {
        exitAction();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              exitAction();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: "Multiple Timers".pageTitle,
          actions: [
            if (multipleTimersState.actionState == ActionState.clean) const NewTimerButton(),
          ],
        ),
        body: Builder(
          builder: (context) {
            if (multipleTimersState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (multipleTimersState.allTimers.isEmpty) {
              return Center(
                child: VWColumn(
                  gap: 20,
                  horizontalAlignment: CrossAxisAlignment.center,
                  verticalAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 80,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    const Text(
                      "No tasks created yet",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }

            return ReorderableListView(
              buildDefaultDragHandles: false,
              padding: const EdgeInsets.only(bottom: 20),
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  multipleTimersState.updatePosition(oldIndex, newIndex);
                });
              },
              children: [
                for (int i = 0; i < multipleTimersState.allTimers.length; i++)
                  TimerCard(
                    key: ValueKey(multipleTimersState.allTimers[i].id),
                    timer: multipleTimersState.allTimers[i],
                  )
              ],
            );
          },
        ),
        bottomNavigationBar: VWIf(
          condition: multipleTimersState.allTimers.isNotEmpty,
          ifFalse: null,
          ifTrue: Container(
            height: 70,
            color: multipleTimersState.actionState == ActionState.running ? const Color(0xFF4E4200) : Theme.of(context).colorScheme.surfaceContainerHigh,
            child: VWRow(
              gap: 20,
              verticalAlignment: CrossAxisAlignment.center,
              horizontalAlignment: MainAxisAlignment.spaceBetween,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                VWRow(
                  gap: 10,
                  children: [
                    getActionButton(),
                    if (multipleTimersState.actionState == ActionState.clean)
                      IconButton.outlined(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: multipleTimersState.autoStart ? Colors.yellow : Theme.of(context).colorScheme.outline,
                          ),
                          foregroundColor: multipleTimersState.autoStart ? Colors.black : null,
                          backgroundColor: multipleTimersState.autoStart ? Colors.yellow : null,
                        ),
                        onPressed: () {
                          multipleTimersState.toggleAutoStart();
                        },
                        icon: const Icon(Icons.repeat),
                      ),
                  ],
                ),
                VWColumn(
                  gap: 5,
                  verticalAlignment: MainAxisAlignment.center,
                  horizontalAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Auto Start: ${multipleTimersState.autoStart ? "On" : "Off"}".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      multipleTimersState.actionState.toString(),
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
