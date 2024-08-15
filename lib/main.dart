import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/app.dart';
import '/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await sharedPreferences.loadPreferences();

  await multipleTasksState.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}
