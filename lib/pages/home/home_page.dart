import 'package:flutter/material.dart';
import '/imports.dart';
import 'components/big_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(height: 20),
              BigButton(
                icon: Icons.list_alt_outlined,
                title: "Multiple Tasks",
                description:
                    "Create multiple tasks and break timers for multiple tasks",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
