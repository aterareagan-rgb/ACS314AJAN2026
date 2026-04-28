import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _usersKey = 'users';
  static const _ordersKey = 'orders';
  static const _currentUserKey = 'currentUser';

  static Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  static Future<List<Map<String, dynamic>>> loadUsers() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(_usersKey);
    if (jsonString == null) {
      final defaultUsers = [
        {
          'id': 'user_john',
          'firstname': 'John',
          'lastname': 'Doe',
          'email': 'john@example.com',
          'phone': '+254700000000',
          'password': 'password123',
        },
        {
          'id': 'user_jane',
          'firstname': 'Jane',
          'lastname': 'Smith',
          'email': 'jane@example.com',
          'phone': '+254711111111',
          'password': 'password123',
        },
      ];
      await saveUsers(defaultUsers);
      return defaultUsers;
    }

    final rawList = jsonDecode(jsonString) as List<dynamic>;
    return rawList.map((item) => Map<String, dynamic>.from(item as Map)).toList();
  }

  static Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await _prefs;
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  static Future<List<Map<String, dynamic>>> loadOrders() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(_ordersKey);
    if (jsonString == null) {
      return [];
    }
    final rawList = jsonDecode(jsonString) as List<dynamic>;
    return rawList.map((item) => Map<String, dynamic>.from(item as Map)).toList();
  }

  static Future<void> saveOrders(List<Map<String, dynamic>> orders) async {
    final prefs = await _prefs;
    await prefs.setString(_ordersKey, jsonEncode(orders));
  }

  static Future<void> saveCurrentUser(Map<String, dynamic> user) async {
    final prefs = await _prefs;
    await prefs.setString(_currentUserKey, jsonEncode(user));
  }

  static Future<Map<String, dynamic>?> loadCurrentUser() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(_currentUserKey);
    if (jsonString == null) return null;
    return Map<String, dynamic>.from(jsonDecode(jsonString) as Map);
  }

  static Future<void> clearCurrentUser() async {
    final prefs = await _prefs;
    await prefs.remove(_currentUserKey);
  }
}
