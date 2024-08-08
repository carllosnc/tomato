import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _sharedPrefs = SharedPrefs._internal();
  late final SharedPreferences prefs;

  factory SharedPrefs() {
    return _sharedPrefs;
  }

  SharedPrefs._internal();

  loadPreferences() async {
    prefs = await SharedPreferences.getInstance();

    //get from shared preferences
    final bool? welcome = prefs.getBool('welcome');

    if (welcome == null) {
      prefs.setBool('welcome', true);
    }
  }
}
