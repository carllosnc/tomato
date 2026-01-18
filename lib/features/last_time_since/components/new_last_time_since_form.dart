import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import 'package:intl/intl.dart';

class NewLastTimeSinceForm extends StatefulWidget {
  const NewLastTimeSinceForm({super.key});

  @override
  State<NewLastTimeSinceForm> createState() => _NewLastTimeSinceFormState();
}

class _NewLastTimeSinceFormState extends State<NewLastTimeSinceForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _create() async {
    if (_formKey.currentState!.validate()) {
      final newItem = LastTimeSince(
        title: _titleController.text,
        time: _selectedDate,
      );

      await lastTimeSinceState.add(newItem);

      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: VWColumn(
          gap: 20,
          verticalAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VWColumn(
              gap: 20,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: textFieldDecoration(hintText: "Title"),
                  style: textFieldStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 16,
                      top: 12,
                      bottom: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(_selectedDate),
                          style: textFieldStyle(),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _create,
                child: "Create".buttonLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
