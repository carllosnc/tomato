import 'package:flutter/material.dart';
import '/imports.dart';

class _SoundState extends ChangeNotifier {
  bool allowSound = true;

  void toggleSound() {
    allowSound = !allowSound;
    sharedPreferences.prefs.setBool('sound', allowSound);
    notifyListeners();
  }
}

var soundState = _SoundState();
