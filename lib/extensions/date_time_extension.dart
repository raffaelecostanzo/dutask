import 'package:dutask/types/task_date_filter.dart';
import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime? {
  bool equalsToFilter(TaskDateFilter taskDateFilter) {
    final date = this;
    if (date == null) return taskDateFilter == TaskDateFilter.all;

    final currentDate = DateUtils.dateOnly(DateTime.now());
    final targetDate = DateUtils.dateOnly(date);

    return switch (taskDateFilter) {
      TaskDateFilter.all => true,
      TaskDateFilter.today => targetDate == currentDate,
      TaskDateFilter.yesterday => targetDate == DateUtils.addDaysToDate(currentDate, -1),
      TaskDateFilter.tomorrow => targetDate == DateUtils.addDaysToDate(currentDate, 1),
    };
  }
}
