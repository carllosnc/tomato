import 'package:flutter/material.dart';
import '/imports/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstTime = SharedPrefs().prefs.getBool('welcome') ?? true;

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      return Welcome(
        onPressed: () {
          setState(() {
            firstTime = false;
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //logo and title
            Image.asset(
              Assets.logo,
              width: 30,
            ),
            const SizedBox(width: 12),
            const Text("Tomato"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          updateTask(context);
        },
        label: const Text("Task"),
        icon: const Icon(Icons.timer),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Pomo(),
        ),
      ),
    );
  }
}
