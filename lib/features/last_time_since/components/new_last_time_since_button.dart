import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import 'new_last_time_since_form.dart';

class NewLastTimeSinceButton extends StatelessWidget {
  const NewLastTimeSinceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: () {
        context.openSheet(
          borderRadius: 25,
          isScrollControlled: false,
          backgroundColor: context.pageBackground,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: context.pageBackground,
            title: "New entry".pageTitle,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(20),
            child: NewLastTimeSinceForm(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
