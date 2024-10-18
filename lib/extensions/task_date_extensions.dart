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
