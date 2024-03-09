import 'package:dutask/utils/constants.dart';

class FormValidator {
  static String? title(String? title) {
    if (title == null || title.trim().isEmpty) return 'Enter some text';
    return null;
  }

  static String? dueDate(String? dueDate) {
    if (dueDate == null || dueDate.isEmpty) return null;
    try {
      final parsedDate = dateFormat.parse(dueDate);
      if (parsedDate.isBefore(DateTime(1970, 1, 1)) ||
          parsedDate.isAfter(DateTime(DateTime.now().year + 10, 12, 31))) {
        return 'Invalid date';
      }
    } catch (error) {
      return 'Invalid date';
    }
    return null;
  }
}
