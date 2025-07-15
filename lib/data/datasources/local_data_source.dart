import 'dart:convert';
import 'package:flutter/services.dart';

class LocalDataSource {
  Future<Map<String, dynamic>> loadJsonData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/schedule.json');
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load JSON data: $e');
    }
  }
}