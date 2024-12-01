import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }

  static Future<bool> setAccessToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', value);
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileDataString = prefs.getString('profile');

    if (profileDataString == null) {
      return <String, dynamic>{};
    }

    try {
      return jsonDecode(profileDataString) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error decoding profile data: $e');
      return <String, dynamic>{};
    }
  }

  static Future<bool> setProfile(Map<String, dynamic> profile) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('profile', json.encode(profile));
  }

  static Future<bool> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('profile');
  }
}
