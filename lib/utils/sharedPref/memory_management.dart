
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SharedPrefsKeys.dart';

class MemoryManagement {
  static SharedPreferences prefs;

  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static void setAccessToken({@required String accessToken}) {
    prefs.setString(SharedPrefsKeys.ACCESS_TOKEN, accessToken);
  }

  static String getAccessToken() {
    return prefs.getString(SharedPrefsKeys.ACCESS_TOKEN);
  }

}
