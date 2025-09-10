import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import 'timer_card_delete_button.dart';

showTimerCardUpdateForm(BuildContext context, CustomTimer timer) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: timer.name);
  double taskTime = double.parse(timer.duration.toString());

  context.openSheet(
    borderRadius: 25,
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: context.pageBackground,
      title: timer.name.pageTitle,
      actions: [
        TimerCardDeleteButton(timer: timer),
      ],
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
    isScrollControlled: false,
    backgroundColor: context.pageBackground,
    bottomBar: Padding(
      padding: const EdgeInsets.all(20),
      child: FilledButton(
        child: "Update Task".buttonLabel,
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            CustomTimer newTimer = CustomTimer(
              id: timer.id,
              name: nameController.text,
              duration: taskTime.toInt(),
              type: timer.type,
              position: timer.position,
            );

            await multipleTimersState.update(newTimer);

            if (context.mounted) {
              Navigator.of(context).pop();
            }
          }
        },
      ),
    ),
    body: StatefulBuilder(builder: (context, setState) {
      return SingleChildScrollView(
        child: Form(
          key: formKey,
          child: VWColumn(
            gap: 30,
            padding: context.formPadding,
            verticalAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: nameController,
                decoration: textFieldDecoration(
                  hintText: "Timer name",
                ),
                style: textFieldStyle(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              VWColumn(
                gap: 10,
                children: [
                  "Duration: ${taskTime.toInt().toString()} min".formLabel,
                  Slider(
                    value: taskTime.toDouble(),
                    min: 1,
                    max: 60,
                    label: taskTime.toString(),
                    onChanged: (double value) {
                      setState(() {
                        taskTime = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }),
  );
}
