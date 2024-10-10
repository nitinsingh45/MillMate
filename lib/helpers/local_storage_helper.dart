import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageHelper {
  static Future<List<Map<String, dynamic>>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString('historyData');
    if (historyJson != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(historyJson));
    }
    return [];
  }

  static Future<void> saveHistory(
      List<Map<String, dynamic>> historyData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('historyData', jsonEncode(historyData));
  }
}
