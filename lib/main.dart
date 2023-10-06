import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/app.dart';
import '/imports/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs().loadPreferences();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}
