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
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

extension ThemeModeMapping on ThemeMode {
  String mapToText() {
    return switch (this) {
      ThemeMode.system => 'System default',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark'
    };
  }
}

extension DateFormatting on String {
  DateTime? getDateOrNull() {
    if (isEmpty) return null;
    try {
      return dateFormat.parse(this);
    } catch (_) {
      return null;
    }
  }
}

extension FilterTypeMapping on FilterType {
  String mapToText() {
    return switch (this) {
      FilterType.status => 'Status',
      FilterType.dueDate => 'Date'
    };
  }
}
