import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import 'timer_card_update_form.dart';

class TimerCard extends StatefulWidget {
  final Timer timer;

  const TimerCard({
    required this.timer,
    super.key,
  });

  @override
  State<TimerCard> createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard> {
  getTaskColor(TimerType type) {
    return type == TimerType.task
        ? Theme.of(context).colorScheme.surfaceContainer
        : const Color(0xFF360000);
  }

  getTaskIcon(TimerType type) {
    return type == TimerType.task
        ? Icons.timer_outlined
        : Icons.pause_circle_outline;
  }

  getTaskLabel(TimerType type) {
    return type == TimerType.task ? "Task" : "Pause";
  }

  @override
  Widget build(BuildContext context) {
    return VWBox(
      onTap: () {
        showTimerCardUpdateForm(context, widget.timer);
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
        color: Colors.white.withOpacity(0),
        width: 1,
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
                index: widget.timer.position,
                child: Container(
                  color: Colors.transparent,
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.drag_handle,
                    color: Colors.white.withOpacity(0.4),
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  VWRow(
                    gap: 10,
                    children: [
                      Text(
                        getTaskLabel(widget.timer.type),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "•",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        Duration(
                          minutes: widget.timer.duration,
                        ).toString().split('.')[0],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Icon(
            size: 30,
            getTaskIcon(widget.timer.type),
            color: Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
