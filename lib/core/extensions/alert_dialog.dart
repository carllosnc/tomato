import 'package:flutter/material.dart';
import 'package:vw/vw.dart';

extension AlertDialogExtension on BuildContext {
  alert({
    required String title,
    required String content,
    required String cancelLabel,
    required String confirmLabel,
    required void Function() onConfirm,
  }) {
    showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: VWText(
            primaryColor: Colors.yellow,
            text: content,
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(cancelLabel),
            ),
            OutlinedButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    );
  }
}
