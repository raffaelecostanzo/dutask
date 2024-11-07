import 'package:dutask/providers/filtered_tasks_provider.dart';
import 'package:flutter/material.dart';

extension DateTimeMapping on DateTime? {
  bool equalsToFilter(TaskDateFilter taskDateFilter) {
    if (this == null) {
      return taskDateFilter == TaskDateFilter.all;
    }
    return switch (taskDateFilter) {
      TaskDateFilter.all => true,
      TaskDateFilter.today => DateUtils.isSameDay(this, DateTime.now()),
      TaskDateFilter.yesterday => DateUtils.dateOnly(this!) ==
          DateUtils.dateOnly(DateUtils.addDaysToDate(DateTime.now(), -1)),
      TaskDateFilter.tomorrow => DateUtils.dateOnly(this!) ==
          DateUtils.dateOnly(DateUtils.addDaysToDate(DateTime.now(), 1)),
    };
  }
}

extension TaskDateFilterMapping on TaskDateFilter {
  String mapToText() {
    return switch (this) {
      TaskDateFilter.all => 'All',
      TaskDateFilter.yesterday => 'Yesterday',
      TaskDateFilter.today => 'Today',
      TaskDateFilter.tomorrow => 'Tomorrow',
    };
  }
}
