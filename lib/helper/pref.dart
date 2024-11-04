import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Pref {
  static late Box _box;

  // Initialize Hive and open the box
  static Future<void> initialize() async {
    await Hive.initFlutter(); // Initialize Hive with Flutter
    _box = await Hive.openBox('myData'); // Open the box named 'myData'
  }

  // Onboarding preference
  static bool get showOnboarding =>
      _box.get('showOnboarding', defaultValue: true);
  static set showOnboarding(bool v) => _box.put('showOnboarding', v);

  // Theme mode preference
  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

  // Retrieve the default theme mode
  static ThemeMode get defaultTheme {
    final data = _box.get('isDarkMode');
    log('data: $data');
    if (data == null) return ThemeMode.system; // Default to system if null
    return data ? ThemeMode.dark : ThemeMode.light; // Return dark or light based on value
  }
}
