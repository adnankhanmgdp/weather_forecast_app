import 'package:shared_preferences/shared_preferences.dart';

class WeatherPreferences {
  static Future<void> saveCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('last_city', city);  // Save city
  }
  static Future<void> saveTemp(String temp) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('last_temp', temp);  // Save city
  }

  static Future<void> saveUnit(bool unit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('unit', unit);  // Save unit
  }

  static Future<String?> getCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_city');  // Retrieve city
  }
  static Future<String?> getTemp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_temp');  // Retrieve city
  }

  static Future<bool?> getUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('unit');  // Retrieve unit
  }
}
