import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:flutter/material.dart';

extension DateTimeMapping on DateTime? {
  bool equalsToFilter(TaskDateFilter taskDateFilter) {
    if (this == null) {
      return taskDateFilter == TaskDateFilter.all;
    }
    switch (taskDateFilter) {
      case TaskDateFilter.all:
        return true;
      case TaskDateFilter.yesterday:
        return DateUtils.dateOnly(this!) ==
            DateUtils.dateOnly(DateUtils.addDaysToDate(DateTime.now(), -1));
      case TaskDateFilter.today:
        return DateUtils.isSameDay(this, DateTime.now());
      case TaskDateFilter.tomorrow:
        return DateUtils.dateOnly(this!) ==
            DateUtils.dateOnly(DateUtils.addDaysToDate(DateTime.now(), 1));
    }
  }
}

extension TaskDateFilterMapping on TaskDateFilter {
  int mapToBottomNavigationBarIndex() {
    switch (this) {
      case TaskDateFilter.all:
        return 0;
      case TaskDateFilter.yesterday:
        return 1;
      case TaskDateFilter.today:
        return 2;
      case TaskDateFilter.tomorrow:
        return 3;
    }
  }

  String mapToText() {
    switch (this) {
      case TaskDateFilter.all:
        return 'All';
      case TaskDateFilter.yesterday:
        return 'Yesterday';
      case TaskDateFilter.today:
        return 'Today';
      case TaskDateFilter.tomorrow:
        return 'Tomorrow';
    }
  }
}

extension IntMapping on int {
  TaskDateFilter mapToDateFilter() {
    switch (this) {
      case 0:
        return TaskDateFilter.all;
      case 1:
        return TaskDateFilter.yesterday;
      case 2:
        return TaskDateFilter.today;
      case 3:
        return TaskDateFilter.tomorrow;
      default:
        return TaskDateFilter.all;
    }
  }
}
