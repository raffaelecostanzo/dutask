import 'package:dutask/utils/constants.dart';
import 'package:characters/characters.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';
    final chars = characters;

    return '${chars.first.toUpperCase()}${chars.skip(1).toString().toLowerCase()}';
  }

  DateTime? getDateOrNull() {
    if (isEmpty) return null;
    try {
      return kDateFormat.parse(this);
    } catch (_) {
      return null;
    }
  }
}
