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
        title: Row(
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              addTask(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Tasks"),
        icon: const Icon(Icons.timer),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Pomo(
            workDuration: Duration(seconds: 10),
            relaxDuration: Duration(seconds: 5),
            name: "Esturdar C#",
          ),
        ),
      ),
    );
  }
}
