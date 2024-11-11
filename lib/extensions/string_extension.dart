import 'package:dutask/utils/constants.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  DateTime? getDateOrNull() {
    if (isEmpty) return null;
    try {
      return dateFormat.parse(this);
    } catch (_) {
      return null;
    }
  }
}
