import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import 'components/new_timer_button.dart';
import 'components/timer_card.dart';
import '/imports.dart';

class MultipleTimersPage extends StatefulWidget {
  const MultipleTimersPage({super.key});

  @override
  State<MultipleTimersPage> createState() => _MultipleTimersPageState();
}

class _MultipleTimersPageState extends State<MultipleTimersPage>
    with SharedState {
  late List<Timer> allTasks;

  @override
  void initState() {
    multipleTasksState.getAll();
    allTasks = multipleTasksState.allTasks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Multiple Timers".pageTitle,
        actions: const [
          NewTimerButton(),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (multipleTasksState.isLoading) {
            return const Center();
          }

          if (multipleTasksState.allTasks.isEmpty) {
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
            physics: const BouncingScrollPhysics(),
            dragStartBehavior: DragStartBehavior.start,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                multipleTasksState.updatePosition(oldIndex, newIndex);
              });
            },
            children: [
              for (int i = 0; i < multipleTasksState.allTasks.length; i++)
                TimerCard(
                  key: ValueKey(multipleTasksState.allTasks[i].position),
                  timer: multipleTasksState.allTasks[i],
                )
            ],
          );
        },
      ),
    );
  }
}
