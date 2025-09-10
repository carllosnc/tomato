import 'package:vw/vw.dart';

import '/imports.dart';
import 'package:flutter/material.dart';

class FocusBreakTimerTask extends StatefulWidget {
  const FocusBreakTimerTask({super.key});

  @override
  State<FocusBreakTimerTask> createState() => _FocusBreakTimerTaskState();
}

class _FocusBreakTimerTaskState extends State<FocusBreakTimerTask> with SharedState {
  final formKey = GlobalKey<FormState>();
  TextEditingController taskNameController = TextEditingController();

  int focusTime = focusBreakState.workDuration.inMinutes;
  int breakTime = focusBreakState.breakDuration.inMinutes;

  @override
  Widget build(BuildContext context) {
    taskNameController.text = focusBreakState.name;

    return FloatingActionButton.extended(
      label: const Text("Task"),
      icon: const Icon(Icons.timer),
      onPressed: () {
        context.openSheet(
          borderRadius: 25,
          isScrollControlled: false,
          backgroundColor: context.pageBackground,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: context.pageBackground,
            title: "Update Task".pageTitle,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          bottomBar: Padding(
            padding: const EdgeInsets.all(20),
            child: FilledButton(
              child: "Update Task".buttonLabel,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  focusBreakState.resetAll(
                    dialogTitle: "The task will be updated",
                    context: context,
                    newName: taskNameController.text,
                    newWorkDuration: Duration(minutes: focusTime),
                    newBreakDuration: Duration(
                      minutes: breakTime,
                    ),
                  );
                }
              },
            ),
          ),
          body: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: VWColumn(
                    padding: context.formPadding,
                    gap: 30,
                    children: [
                      TextFormField(
                        controller: taskNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: textFieldDecoration(
                          hintText: "Task Name",
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VWColumn(
                        gap: 10,
                        children: [
                          "🤔 Focus time: ${focusTime.toString()} min".formLabel,
                          Slider(
                            value: focusTime.toDouble(),
                            min: 1,
                            max: 60,
                            label: focusTime.toString(),
                            onChanged: (double value) {
                              setState(() {
                                focusTime = value.toInt();
                              });
                            },
                          ),
                        ],
                      ),
                      VWColumn(
                        gap: 10,
                        children: [
                          "😎 Break time: ${breakTime.toString()} min".formLabel,
                          Slider(
                            value: breakTime.toDouble(),
                            min: 1,
                            max: 60,
                            label: breakTime.toString(),
                            onChanged: (double value) {
                              setState(() {
                                breakTime = value.toInt();
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
