import 'package:dutask/types/task_status_filter.dart';

extension TaskStatusFilterExtension on TaskStatusFilter {
  String mapToText() {
    return switch (this) {
      TaskStatusFilter.all => 'All',
      TaskStatusFilter.active => 'Active',
      TaskStatusFilter.started => 'Started',
      TaskStatusFilter.completed => 'Completed',
    };
  }
}
