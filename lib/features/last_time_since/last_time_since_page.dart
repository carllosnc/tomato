import 'package:flutter/material.dart';
import '/imports.dart';

class LastTimeSincePage extends StatelessWidget {
  const LastTimeSincePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Last Time Since".pageTitle,
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
