import 'package:shared_preferences/shared_preferences.dart';

class _SharedPrefs {
  late final SharedPreferences prefs;

  loadPreferences() async {
    prefs = await SharedPreferences.getInstance();

    final bool? welcome = prefs.getBool('welcome');
    final bool? sound = prefs.getBool('sound');

    if (welcome == null) {
      prefs.setBool('welcome', true);
    }

    if (sound == null) {
      prefs.setBool('sound', true);
    }
  }
}

var sharedPreferences = _SharedPrefs();
