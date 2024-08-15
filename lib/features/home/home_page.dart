import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports.dart';
import 'components/big_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: VWRow(
          gap: 10,
          horizontalAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.logo,
              width: 30,
            ),
            const Text("Tomato"),
          ],
        ),
      ),
      body: VWColumn(
        horizontalAlignment: CrossAxisAlignment.center,
        verticalAlignment: MainAxisAlignment.center,
        gap: 20,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: [
          BigButton(
            icon: Icons.timer_outlined,
            title: "Focus and Break",
            description:
                "Configure your focus and break timers for just one task",
            onTap: () {
              router.push('/focus_break');
            },
          ),
          BigButton(
            icon: Icons.list_alt_outlined,
            title: "Multiple Timers",
            description: "Create multiple timers for tasks or breaks",
            onTap: () {
              router.push('/multiple_timers');
            },
          ),
        ],
      ),
    );
  }
}
