// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import '/imports.dart';
import 'package:vw/vw.dart';

class NewTimerButton extends StatefulWidget {
  const NewTimerButton({
    super.key,
  });

  @override
  State<NewTimerButton> createState() => _NewTimerButtonState();
}

class _NewTimerButtonState extends State<NewTimerButton> with SharedState, LocalizeMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  double _taskTime = 15;
  CustomTimerType _timerType = CustomTimerType.task;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        context.openSheet(
          isScrollControlled: false,
          borderRadius: 25,
          backgroundColor: context.pageBackground,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: context.pageBackground,
            title: "New timer".localize.pageTitle,
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
              child: "Create".localize.buttonLabel,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final newTask = CustomTimer(
                    position: multipleTimersState.allTimers.length,
                    name: _nameController.text,
                    duration: _taskTime.toInt(),
                    type: _timerType,
                  );

                  await multipleTimersState.add(newTask);
                  _nameController.text = "";

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
                key: _formKey,
                child: VWColumn(
                  gap: 30,
                  padding: context.formPadding,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: textFieldDecoration(
                        hintText: "Timer name".localize,
                      ),
                      style: textFieldStyle(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name cannot be empty'.localize;
                        }
                        return null;
                      },
                    ),
                    VWColumn(
                      gap: 10,
                      children: [
                        "${"Duration: ".localize}${_taskTime.toInt().toString()} ${"min".localize}".formLabel,
                        Slider(
                          value: _taskTime.toDouble(),
                          min: 1,
                          max: 60,
                          label: _taskTime.toString(),
                          onChanged: (double value) {
                            setState(() {
                              _taskTime = value;
                            });
                          },
                        ),
                      ],
                    ),
                    VWColumn(
                      gap: 10,
                      children: [
                        "Timer type".localize.formLabel,
                        VWRow(
                          gap: 10,
                          children: [
                            Expanded(
                              child: RadioListTile<CustomTimerType>(
                                visualDensity: VisualDensity.compact,
                                shape: context.radioListShape,
                                title: Text('Task'.localize),
                                value: CustomTimerType.task,
                                groupValue: _timerType,
                                onChanged: (CustomTimerType? value) {
                                  setState(() {
                                    _timerType = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<CustomTimerType>(
                                visualDensity: VisualDensity.compact,
                                shape: context.radioListShape,
                                title: Text('Pause'.localize),
                                value: CustomTimerType.pause,
                                groupValue: _timerType,
                                onChanged: (CustomTimerType? value) {
                                  setState(() {
                                    _timerType = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
