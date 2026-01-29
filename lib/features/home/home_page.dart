import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import 'package:vw/vw.dart';
import 'components/big_button.dart';
import '/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Tomato".localize.pageTitle,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              value: localizeState.currentLanguage,
              dropdownColor: Theme.of(context).primaryColor,
              items: localizeState.languages.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  localizeState.setLanguage(newValue);
                }
              },
            ),
          ),
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
            title: "Focus and Break".localize,
            description: "Focus and break for just one task".localize,
            onTap: () {
              router.push('/focus_break');
            },
          ),
          BigButton(
            icon: Icons.list_alt_outlined,
            title: "Multiple Timers".localize,
            description: "Set multiple timers for tasks and breaks".localize,
            onTap: () {
              router.push('/multiple_timers');
            },
          ),
          BigButton(
            icon: Icons.calendar_month_outlined,
            title: "Last time since".localize,
            description: "Register the last time since you do something".localize,
            onTap: () {
              router.push('/last_time_since');
            },
          ),
        ],
      ),
    );
  }
}
