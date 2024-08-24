import 'package:flutter/material.dart';
import '/imports.dart';

class TimerCardDeleteButton extends StatelessWidget {
  final CustomTimer timer;

  const TimerCardDeleteButton({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: Colors.red.shade300,
      ),
      onPressed: () {
        context.alert(
          title: "Delete timer",
          content: "Are you sure you want to delete [<pc><b>${timer.name}</b></pc>?]",
          cancelLabel: "Cancel",
          confirmLabel: "Delete",
          onConfirm: () async {
            await multipleTimersState.delete(timer.id!, timer.position);

            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }
}
