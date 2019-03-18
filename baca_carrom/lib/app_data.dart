import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  final String _kPlayerId = "playerid";
  static String playerId = "";

  Future<String> getPlayerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kPlayerId) ?? "";
  }

  Future<bool> setPlayerId(String value) async {
    playerId = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kPlayerId, value);
  }

}
