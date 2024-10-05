import 'package:dutask/utils/constants.dart';
import 'package:flutter/material.dart';

extension SnackBarShow on BuildContext {
  void showSnackBarWithUndo(VoidCallback undoCallback, String snackBarMessage) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(snackBarMessage),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => undoCallback(),
        ),
      ),
    );
  }
}

extension StringUtils on String {
  String capitalize() {
    if (this.isEmpty) return '';
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}

extension ThemeModeMapping on ThemeMode {
  String mapToString() {
    switch (this) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}

extension DateFormatting on String {
  DateTime? getDateOrNull() {
    if (this.isEmpty) return null;
    try {
      return dateFormat.parse(this);
    } catch (_) {
      return null;
    }
  }
}
