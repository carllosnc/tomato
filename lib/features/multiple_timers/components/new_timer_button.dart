import 'package:flutter/material.dart';
import '/imports.dart';
import 'package:vw/vw.dart';

class NewTimerButton extends StatefulWidget {
  const NewTimerButton({super.key});

  @override
  State<NewTimerButton> createState() => _NewTimerButtonState();
}

class _NewTimerButtonState extends State<NewTimerButton> {
  GlobalKey formKey = GlobalKey();
  final nameController = TextEditingController();
  double taskTime = 15;
  TimerType _timerType = TimerType.task;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        VWPage.open(
          isScrollControlled: false,
          backgroundColor: context.pageBackground,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: context.pageBackground,
            title: "New timer".title,
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
              onPressed: () {},
              child: "Create".buttonLabel,
            ),
          ),
          context: context,
          body: StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: VWColumn(
                gap: 30,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: [
                  TextField(
                    decoration: textFieldDecoration(
                      hintText: "Timer name",
                    ),
                    style: textFieldStyle(),
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
                  VWColumn(
                    gap: 10,
                    children: [
                      "Timer type".formLabel,
                      VWRow(
                        gap: 10,
                        children: [
                          Expanded(
                            child: RadioListTile<TimerType>(
                              visualDensity: VisualDensity.compact,
                              shape: context.radioListShape,
                              title: const Text('Task'),
                              value: TimerType.task,
                              groupValue: _timerType,
                              onChanged: (TimerType? value) {
                                setState(() {
                                  _timerType = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<TimerType>(
                              visualDensity: VisualDensity.compact,
                              shape: context.radioListShape,
                              title: const Text('Pause'),
                              value: TimerType.pause,
                              groupValue: _timerType,
                              onChanged: (TimerType? value) {
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
            );
          }),
        );
      },
    );
  }
}
