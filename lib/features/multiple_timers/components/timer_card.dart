import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import 'timer_card_update_form.dart';

class TimerCard extends StatefulWidget {
  final CustomTimer timer;

  const TimerCard({
    required this.timer,
    super.key,
  });

  @override
  State<TimerCard> createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard> with SharedState {
  getStates() {
    return {
      'isRunning': widget.timer.id == multipleTimersState.currentTimer?.id && multipleTimersState.actionState == ActionState.running,
      'isPaused': widget.timer.id == multipleTimersState.currentTimer?.id && multipleTimersState.actionState == ActionState.paused,
      'isTaskFinished': multipleTimersState.finishedTimers.contains(widget.timer),
      'isClean': multipleTimersState.actionState == ActionState.clean,
      'canReorder': multipleTimersState.actionState == ActionState.clean,
      'isCurrentTimer': widget.timer.id == multipleTimersState.currentTimer?.id,
      'isATask': widget.timer.type == CustomTimerType.task,
      'isABreak': widget.timer.type == CustomTimerType.pause,
    };
  }

  getTaskColor(CustomTimerType type) {
    return type == CustomTimerType.task ? Theme.of(context).colorScheme.surfaceContainer : const Color(0xFF360000);
  }

  getPercent() {
    var currentDuration = multipleTimersState.currentDuration!.inSeconds;
    var taskDuration = Duration(minutes: widget.timer.duration).inSeconds;

    return ((currentDuration * 100) ~/ taskDuration / 100);
  }

  Widget getTaskIcon(CustomTimerType type) {
    if (getStates()['isTaskFinished']) {
      return const Icon(
        Icons.check,
        size: 30,
        color: Color(0xff46ff92),
      );
    }

    if (getStates()['isPaused']) {
      return Icon(
        Icons.pause,
        size: 30,
        color: Colors.blue.shade300,
      );
    }

    if (getStates()['isRunning']) {
      return TweenAnimationBuilder(
        tween: Tween<double>(
          begin: 0,
          end: getPercent(),
        ),
        duration: const Duration(seconds: 1),
        builder: (context, value, child) {
          return CircularProgressIndicator(
            value: value,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            strokeWidth: 2,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
          );
        },
      );
    }

    return Icon(
      widget.timer.type == CustomTimerType.task ? Icons.timer_outlined : Icons.pause_circle_outline,
      size: 30,
      color: Colors.white.withValues(alpha: 0.3),
    );
  }

  getTaskNameStyle() {
    if (getStates()['isTaskFinished']) {
      return const TextStyle(
        color: Color(0x86ffffff),
        fontSize: 16,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.lineThrough,
      );
    }

    return const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
  }

  getTaskLabel(CustomTimerType type) {
    return type == CustomTimerType.task ? "Task" : "Pause";
  }

  getDuration() {
    if (getStates()['isRunning']) {
      return {
        'text': multipleTimersState.currentDuration?.formatToHHMM(),
        'color': Colors.yellow,
        'fontSize': 18.toDouble(),
      };
    }

    if (getStates()['isPaused']) {
      return {
        'text': multipleTimersState.currentDuration?.formatToHHMM(),
        'color': Colors.blue.shade300,
        'fontSize': 18.toDouble(),
      };
    }

    return {
      'text': Duration(minutes: widget.timer.duration).formatToHHMM(),
      'color': Colors.white.withValues(alpha: 0.5),
      'fontSize': 15.toDouble(),
    };
  }

  getBorderColor() {
    if (getStates()['isRunning']) {
      return Colors.yellow;
    }

    if (getStates()['isPaused']) {
      return Colors.blue.shade300;
    }

    return Colors.white.withValues(alpha: 0);
  }

  @override
  Widget build(BuildContext context) {
    return VWBox(
      onTap: () {
        if (getStates()['isClean']) {
          showTimerCardUpdateForm(context, widget.timer);
        }
      },
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      key: ValueKey(widget.timer.id),
      width: 200,
      padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
      border: Border.all(
        color: getBorderColor(),
        width: 2,
      ),
      color: getTaskColor(widget.timer.type),
      child: VWRow(
        verticalAlignment: CrossAxisAlignment.center,
        horizontalAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VWRow(
            verticalAlignment: CrossAxisAlignment.center,
            children: [
              ReorderableDragStartListener(
                enabled: getStates()['canReorder'],
                index: widget.timer.position,
                child: Container(
                  color: Colors.transparent,
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.drag_handle,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ),
              VWColumn(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 230,
                    ),
                    child: Text(
                      widget.timer.name.capitalize(),
                      style: getTaskNameStyle(),
                    ),
                  ),
                  VWRow(
                    gap: 10,
                    verticalAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTaskLabel(widget.timer.type),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      Text(
                        "•",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      Text(
                        getDuration()['text'],
                        style: TextStyle(
                          fontSize: getDuration()['fontSize'],
                          color: getDuration()['color'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          getTaskIcon(widget.timer.type),
        ],
      ),
    );
  }
}
