import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import 'components/big_button.dart';
import '/imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Tomato".pageTitle,
        actions: [
          IconButton(
            onPressed: () {
              router.push('/settings');
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: VWColumn(
        horizontalAlignment: CrossAxisAlignment.center,
        verticalAlignment: MainAxisAlignment.center,
        gap: 20,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: [
          Image.asset(
            Assets.logo,
            width: 120,
          ),
          const SizedBox(height: 10),
          BigButton(
            icon: Icons.timer_outlined,
            title: "Focus and Break",
            description: "Focus and break for just one task",
            onTap: () {
              router.push('/focus_break');
            },
          ),
          BigButton(
            icon: Icons.list_alt_outlined,
            title: "Multiple Timers",
            description: "Set multiple timers for tasks and breaks",
            onTap: () {
              router.push('/multiple_timers');
            },
          ),
        ],
      ),
    );
  }
}
