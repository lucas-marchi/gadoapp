import 'dart:convert';
import 'package:gadoapp/services/database_service.dart';
import 'package:http/http.dart' as http;
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'http://192.168.30.229:8080/api';
  static const String _syncKey = 'lastSync';
  static const String _lastSyncKey = 'lastSync';

  Future<bool> syncData(List<Herd> herds, List<Bovine> bovines) async {
    try {
      Future<bool> _sendData(String endpoint, List<dynamic> data) async {
        try {
          final response = await http.post(
            Uri.parse('$_baseUrl/$endpoint'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'data': data,
            }),
          );

          print(
              'Resposta do servidor (${response.statusCode}): ${response.body}');

          return response.statusCode == 200;
        } catch (e) {
          print('Erro ao sincronizar $endpoint: $e');
          return false;
        }
      }

      final herdsSuccess =
          await _sendData('sync/herds', herds.map((h) => h.toJson()).toList());

      if (herdsSuccess) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_syncKey, DateTime.now().toIso8601String());
      }

      return herdsSuccess;
    } catch (e) {
      print('Erro na sincronização: $e');
      return false;
    }
  }

  Future<void> updateLastSync(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_syncKey, date.toIso8601String());
  }

  Future<DateTime?> getLastSync() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString(_lastSyncKey);
    return dateString != null ? DateTime.parse(dateString) : null;
  }
}
