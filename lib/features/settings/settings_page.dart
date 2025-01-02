import 'package:Tomato/shared_state/sound_state.dart';
import 'package:flutter/material.dart';
import '/imports.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SharedState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Settings".pageTitle,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text(
              "Sound",
              style: TextStyle(
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
              "Allow sound to play when timer ends",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
