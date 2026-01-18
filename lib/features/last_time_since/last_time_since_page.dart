import 'package:flutter/material.dart';
import '/imports.dart';
import 'components/new_last_time_since_button.dart';

import 'components/last_time_since_list.dart';

class LastTimeSincePage extends StatefulWidget {
  const LastTimeSincePage({super.key});

  @override
  State<LastTimeSincePage> createState() => _LastTimeSincePageState();
}

class _LastTimeSincePageState extends State<LastTimeSincePage> with SharedState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: "Last Time Since".pageTitle,
      ),
      body: const LastTimeSinceList(),
      floatingActionButton: const NewLastTimeSinceButton(),
    );
  }
}
