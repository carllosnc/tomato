import 'package:flutter/material.dart';
import '/imports.dart';

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

  taskNameController.text = timerFocusState.name;
  int focusTime = timerFocusState.workDuration.inMinutes;
  int breakTime = timerFocusState.breakDuration.inMinutes;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: SizedBox(
                height: 600,
                width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      "UPDATE TASK",
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ConstrainedBox(
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
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 25),
                            hintText: "Task Name",
                            //text white
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontWeight: FontWeight.normal,
                            ),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "🤔 Focus time: ${focusTime.toString()} min",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "😎 Break time: ${breakTime.toString()} min",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.of(context).pop();
                              timerFocusState.resetAll(
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
