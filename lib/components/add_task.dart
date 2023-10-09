import 'package:flutter/material.dart';

addTask(BuildContext context) {
  int focusTime = 25;
  int relaxTime = 5;
  TextEditingController taskNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                      "CREATE A TASK",
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    //rounded textfield
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
                            //background color
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                            //border
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
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
                            "😎 Relax time: ${relaxTime.toString()} min",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Slider(
                          value: relaxTime.toDouble(),
                          min: 1,
                          max: 60,
                          label: relaxTime.toString(),
                          onChanged: (double value) {
                            setState(() {
                              relaxTime = value.toInt();
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
                              print("adding new here!");
                            }
                          },
                          child: const Text("Create Task"),
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
