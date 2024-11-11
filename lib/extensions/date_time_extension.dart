import 'package:dutask/types/task_date_filter.dart';
import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime? {
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
