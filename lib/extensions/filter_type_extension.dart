import 'package:dutask/types/task_filter.dart';

extension FilterTypeExtension on TaskFilter {
  String mapToText() {
    return switch (this) {
      TaskFilter.status => 'Status',
      TaskFilter.dueDate => 'Due date'
    };
  }
}
