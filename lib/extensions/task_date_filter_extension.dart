import 'package:dutask/types/task_date_filter.dart';

extension TaskDateFilterExtension on TaskDateFilter {
  String mapToText() {
    return switch (this) {
      TaskDateFilter.all => 'All',
      TaskDateFilter.yesterday => 'Yesterday',
      TaskDateFilter.today => 'Today',
      TaskDateFilter.tomorrow => 'Tomorrow',
    };
  }
}
