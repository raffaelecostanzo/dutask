import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String mapToText() {
    return switch (this) {
      ThemeMode.system => 'System default',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark'
    };
  }
}
