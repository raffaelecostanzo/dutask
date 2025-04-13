import 'package:collection/collection.dart';
import 'package:dutask/utils/constants.dart';

class FormValidator {
  static String? title(String? title) {
    if (title == null || title.trim().isEmpty) return 'Enter some text';

    return null;
  }

  static String? icon(String? iconName, List<String> iconList) {
    if (!iconList.contains(iconName)) return 'Enter a valid icon name';

    return null;
  }

  static String? list(String? listId, List<String> idList) {
    if (listId == '__no_list__') return null;
    final foundList = idList.firstWhereOrNull(
      (list) => list == listId,
    );
    if (foundList == null) return 'Enter a valid list name';

    return null;
  }

  static String? dueDate(String? dueDate) {
    if (dueDate == null || dueDate.isEmpty) return null;
    try {
      final parsedDate = kDateFormat.parse(dueDate);
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
