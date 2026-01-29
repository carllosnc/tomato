import 'package:localize/localize.dart';
import 'package:flutter/material.dart';
import '/imports.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SharedState, LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Settings".localize.pageTitle,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              "Sound".localize,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            leading: const Icon(Icons.volume_up),
            trailing: Switch(
              value: soundState.allowSound,
              onChanged: (value) {
                setState(() {
                  soundState.toggleSound();
                });
              },
            ),
            subtitle: Text(
              "Allow sound to play when timer ends".localize,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
