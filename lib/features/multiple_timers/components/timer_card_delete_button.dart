import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports.dart';

class TimerCardDeleteButton extends StatelessWidget {
  final Timer timer;

  const TimerCardDeleteButton({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: Colors.red.shade300,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Delete timer"),
              content: VWText(
                primaryColor: Colors.yellow,
                text:
                    "Are you sure you want to delete [<pc><b>${timer.name}</b></pc>?]",
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await multipleTasksState.delete(timer.id!, timer.position);

                    if (context.mounted) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
