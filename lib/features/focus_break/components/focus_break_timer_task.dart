import '/imports.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.greenAccent,
    ),
  );
}

focusBreakTask(BuildContext context) {
  TextEditingController taskNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  taskNameController.text = focusBreakState.name;
  int focusTime = focusBreakState.workDuration.inMinutes;
  int breakTime = focusBreakState.breakDuration.inMinutes;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 600,
                width: double.infinity,
                child: Column(
                  children: [
                    "Update Task".title,
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 50,
                      ),
                      child: TextFormField(
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
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "🤔 Focus time: ${focusTime.toString()} min".formLabel,
                        const SizedBox(height: 10),
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
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "😎 Break time: ${breakTime.toString()} min".formLabel,
                        const SizedBox(height: 10),
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context).pop();
                            focusBreakState.resetAll(
                              dialogTitle: "The task will be updated",
                              context: context,
                              newName: taskNameController.text,
                              newWorkDuration: Duration(minutes: focusTime),
                              newBreakDuration: Duration(minutes: breakTime),
                            );
                          }
                        },
                        child: const Text("Update Task"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
